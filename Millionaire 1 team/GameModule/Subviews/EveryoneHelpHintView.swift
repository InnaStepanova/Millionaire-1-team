//
//  EveryoneHelpHintView.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 09.02.2023.
//

import UIKit

final class EveryoneHelpHintView: GradientView {
        
    private var percents = [String: Int]()
    
    private enum Constants {
        static let standartTopIndentation: CGFloat = 20
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewBottomIndetation: CGFloat = -50
        static let dissmissButtonBottom: CGFloat = -20
        static let stackViewSpacing: CGFloat = 20
        static let horizotnalStackViewHeight: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        
        static let textColor: UIColor = .white
    }
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.bounds = UIScreen.main.nativeBounds
        view.backgroundColor = .black
        return view
    }()
    
    private let progressBarsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private lazy var dissmissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with percents: [String: Int]) {
        self.percents = percents
    }
    
    private func configureStackView() {
        
        let letters = percents.keys.sorted()
        
        for letter in letters {

            if let percent = percents[letter] {
                
                let letterLabel: UILabel = {
                    let label = UILabel()
                    label.text = letter
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = .white
                    return label
                }()
                
                let percentLabel: UILabel = {
                    let label = UILabel()
                    label.text = percent.setEmptyAtBegin()
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = .white
                    return label
                }()
                
                let progressBar = UIProgressView(progressViewStyle: .bar)
                progressBar.layer.cornerRadius = Constants.cornerRadius
                progressBar.clipsToBounds = true
                progressBar.progress = Float(percent) / 100
                
                let horizotnalStackView = UIStackView(arrangedSubviews: [letterLabel, progressBar, percentLabel])
                horizotnalStackView.distribution = .fill
                horizotnalStackView.spacing = Constants.stackViewSpacing
                
                horizotnalStackView.heightAnchor.constraint(equalToConstant: Constants.horizotnalStackViewHeight).isActive = true
                
                progressBarsStackView.addArrangedSubview(horizotnalStackView)
            }
        }
    }
    
    @objc private func dissmissButtonTapped() {
        dissmissAlert()
    }
    
    func dissmissAlert() {
        UIView.animate(withDuration: 0.3) {
            [weak self] in
            guard let self = self else { return }
            self.alpha = 0
            self.backgroundView.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    func showCustomAlert(for mainView: UIView) {
        dropBackgroundShadow()
        configureStackView()
        frame = CGRect(x: 40,
                       y: -320,
                       width: mainView.bounds.size.width - 80,
                       height: 320)
        
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        UIView.animate(withDuration: 0.3) {
            self.center = mainView.center
        }
    }
    
    private func dropBackgroundShadow() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.backgroundView.alpha = 0.3
        }
    }
    
    private func setupUI() {
        
        let subviews = [backgroundView, progressBarsStackView, dissmissButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            progressBarsStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.standartTopIndentation),
            progressBarsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.standartLeadingIndentation),
            progressBarsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.standartTrailingIndentation),
            progressBarsStackView.bottomAnchor.constraint(equalTo: dissmissButton.bottomAnchor, constant: Constants.stackViewBottomIndetation)
        ])
        
        NSLayoutConstraint.activate([
            dissmissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.dissmissButtonBottom),
            dissmissButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
