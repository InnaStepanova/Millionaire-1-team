//
//  QuestionView.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 05.02.2023.
//

import UIKit

final class QuestionView: UIView {
    
    private enum Constants {
        static let textColor: UIColor = .white
        static let logoImageViewWidthHeight: CGFloat = 100
        static let questionLabelLeading: CGFloat = 20
    }
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Constants.textColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let numberQuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        return label
    }()
    
    private let priceQuestionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.textColor
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberQuestionLabel,
                                                       priceQuestionLabel])
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with question: String, _ questionNumber: Int, _ price: Int) {
        questionLabel.text = question
        numberQuestionLabel.text = "Question \(questionNumber)"
        priceQuestionLabel.text = "\(price) RUB"
    }
    
    private func setupUI() {
        let subviews = [logoImageView, questionLabel, bottomStackView]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoImageViewWidthHeight),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoImageViewWidthHeight),
            logoImageView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constants.questionLabelLeading),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
