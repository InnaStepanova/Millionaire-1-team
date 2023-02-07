//
//  GradientView.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 05.02.2023.
//

import UIKit

final class AnswerView: UIView {
    
    private enum Constants {
        static let leadingIndentation: CGFloat = 20
        static let trailingIndentation: CGFloat = -20
        static let cornerRadius: CGFloat = 10

    }
    
    var option = String()
    var title = String()
    
    private lazy var answerButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .right
        button.tintColor = .white
        return button
    }()
    
    private lazy var optionAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        dropShadow()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        optionAnswerLabel.text = option
        answerButton.setTitle(title, for: .normal)
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.borderColor = UIColor.gray.cgColor
        gradientLayer.borderWidth = 1
        let colors: [UIColor] = [#colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1), #colorLiteral(red: 0.1300314665, green: 0.2300171852, blue: 0.3798839748, alpha: 1), #colorLiteral(red: 0.2530327737, green: 0.4159591794, blue: 0.5364745855, alpha: 1)]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.cornerRadius = Constants.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    func configure(with bodyAnswer: String, _ answerOption: String, _ action: UIAction) {
        option = answerOption
        title = bodyAnswer
        answerButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupUI() {
        let subviews = [optionAnswerLabel, answerButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
                
        NSLayoutConstraint.activate([
            optionAnswerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingIndentation),
            optionAnswerLabel.topAnchor.constraint(equalTo: topAnchor),
            optionAnswerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            answerButton.topAnchor.constraint(equalTo: topAnchor),
            answerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            answerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingIndentation),
            answerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
