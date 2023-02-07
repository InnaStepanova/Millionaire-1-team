//
//  ViewController.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit

@available(iOS 14.0, *)
final class GameViewController: UIViewController {
    
    private enum Constants {
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewSpacing: CGFloat = 10
        static let answersStackViewHeight: CGFloat = 400
        static let questionViewHeight: CGFloat = 150
    }
    
    //MARK: - mock data
    let answers = ["1909", "3202.729847928", "Pokemon", "Бетховен"]
    
    let hints = ["fiftyOnFifty": "forbiddenFiftyOnFifty",
                 "friendCall": "forbiddenFriendCall",
                 "everyoneHelp": "forbiddenEveryoneHelp"]
    
    let backgroundImageView = UIImageView(image: UIImage(named: "background"))
    
    let questionView = QuestionView()
            
    private var answersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private var hintsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnswersStackView()
        configureHintsStackView()
        setupUI()
        questionView.configure(with: "Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire? Who wants to be a millionaire?", 1, 500)

    }
    
    @available(iOS 14.0, *)
    private func configureAnswersStackView() {
        answers.forEach {
            let answerView = AnswerView()
            answerView.configure(with: $0, "А", UIAction(handler: { action in
                print(answerView.title)
            }))
            answersStackView.addArrangedSubview(answerView)
        }
    }
    
    @available(iOS 14.0, *)
    private func configureHintsStackView() {
        for (key, value) in hints {
            let hintButton = UIButton(type: .system)
            hintButton.setImage(UIImage(named: key)?.withRenderingMode(.alwaysOriginal), for: .normal)
            hintButton.setImage(UIImage(named: value)?.withRenderingMode(.alwaysOriginal), for: .selected)
            hintButton.imageView?.contentMode = .scaleAspectFit
            hintButton.tintColor = .clear
            hintButton.addAction(UIAction(handler: { _ in
                if !hintButton.isSelected {
                    hintButton.isSelected.toggle()
                    print(#function)
                } else {
                    print("Hint used already")
                }
            }), for: .touchUpInside)
            hintsStackView.addArrangedSubview(hintButton)
        }

    }
    
    private func setupUI() {
        let subviews = [backgroundImageView,
                        questionView,
                        answersStackView,
                        hintsStackView
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
            questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartLeadingIndentation),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation),
            questionView.heightAnchor.constraint(equalToConstant: Constants.questionViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            answersStackView.topAnchor.constraint(equalTo: questionView.bottomAnchor),
            answersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartLeadingIndentation),
            answersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation),
            answersStackView.heightAnchor.constraint(equalToConstant: Constants.answersStackViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            hintsStackView.topAnchor.constraint(equalTo: answersStackView.bottomAnchor),
            hintsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.standartLeadingIndentation),
            hintsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.standartTrailingIndentation),
            hintsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

