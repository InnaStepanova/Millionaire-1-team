//
//  GradientView.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 05.02.2023.
//

import UIKit

protocol AnswerViewDelegate: AnyObject {
    func answerButtonTapped(with userAnswer: String, answerView: AnswerView)
}

final class AnswerView: GradientButton {
    
    weak var delegate: AnswerViewDelegate?
    
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
    
    @objc private func answerButtonTapped(_ sender: UIButton) {
        delegate?.answerButtonTapped(with: title, answerView: self)
    }
    
    func updateGradient(with isRight: Bool) {
            if isRight {
                gradientLayer.colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)].map { $0.cgColor }
            } else {
                gradientLayer.colors = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)].map { $0.cgColor }
            }
    }
    
    func updateGradientChosenAnswer() {
        gradientLayer.colors = [#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)].map { $0.cgColor }
    }
        
    func configure(with bodyAnswer: String, _ answerOption: String) {
        option = answerOption
        title = bodyAnswer
        answerButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    func fiftyOnFiftySetup() {
        self.alpha = 0.5
        answerButton.isEnabled = false
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
