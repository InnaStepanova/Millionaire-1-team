//
//  GameOverViewController.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 08.02.2023.
//

import UIKit

protocol GameOverViewControllerDelegate: AnyObject {
    func restartGame(isGameOver: Bool)
}

final class GameOverViewController: UIViewController {
    
    weak var delegate: GameOverViewControllerDelegate?
    
    private enum Constants {
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewSpacing: CGFloat = 20
        static let stackViewHeight: CGFloat = 100
        
        static let textColor: UIColor = .white
    }
    
    private let gameOverTitle: String
    private let score: Int
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var restartButton: GradientButton  = {
        let button = GradientButton(type: .system)
        button.setImage(UIImage(systemName: "gobackward"), for: .normal)
        button.tintColor = Constants.textColor
        button.addTarget(self, action: #selector(restartButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var scoreButton = {
        let button = GradientButton(type: .system)
        button.setImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
        button.tintColor = Constants.textColor
        button.addTarget(self, action: #selector(scoreButtonPressed), for: .touchUpInside)
        button.setTitle("Score", for: .normal)
        return button
    }()
    
    private let backgroundImageView = UIImageView(image: Resourses.Images.bacgroundImage)
    
    private lazy var buttonsStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreButton, restartButton])
        stackView.dropShadow()
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private let logoImageView = {
        let imageView = UIImageView(image: Resourses.Images.millioneireImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(title: String, score: Int) {
        self.gameOverTitle = title
        self.score = score
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func restartButtonPressed() {
        delegate?.restartGame(isGameOver: false)
        dismiss(animated: true)
    }
    
    @objc private func scoreButtonPressed() {
        print(#function)
    }
    
    private func setupUI() {
        
        titleLabel.text = """
\(gameOverTitle)
Your score:
\(score)
"""
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.repeat, .autoreverse]) {
            self.logoImageView.alpha = 0.8
        }
        
        let subviews = [backgroundImageView,
                        titleLabel,
                        buttonsStackView,
                        logoImageView
        ]
        
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartLeadingIndentation),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        ])
    }
}
