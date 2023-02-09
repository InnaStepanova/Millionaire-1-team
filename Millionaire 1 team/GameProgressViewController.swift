//
//  GameProgressViewController.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit

struct PrizeTable {
    var qwestionNumber: Int
    var winningSumm: Int
    var color: ColorImage
}

extension PrizeTable {
    static func getPrizeTable() -> [PrizeTable] {
        [PrizeTable(qwestionNumber: 15, winningSumm: 1000000, color: .gold),
         PrizeTable(qwestionNumber: 14, winningSumm: 500000, color: .purple),
         PrizeTable(qwestionNumber: 13, winningSumm: 250000, color: .purple),
         PrizeTable(qwestionNumber: 12, winningSumm: 125000, color: .purple),
         PrizeTable(qwestionNumber: 11, winningSumm: 64000, color: .purple),
         PrizeTable(qwestionNumber: 10, winningSumm: 32000, color: .blue),
         PrizeTable(qwestionNumber: 9, winningSumm: 16000, color: .purple),
         PrizeTable(qwestionNumber: 8, winningSumm: 8000, color: .purple),
         PrizeTable(qwestionNumber: 7, winningSumm: 4000, color: .purple),
         PrizeTable(qwestionNumber: 6, winningSumm: 2000, color: .purple),
         PrizeTable(qwestionNumber: 5, winningSumm: 1000, color: .blue),
         PrizeTable(qwestionNumber: 4, winningSumm: 500, color: .purple),
         PrizeTable(qwestionNumber: 3, winningSumm: 300, color: .purple),
         PrizeTable(qwestionNumber: 2, winningSumm: 200, color: .purple),
         PrizeTable(qwestionNumber: 1, winningSumm: 100, color: .green)
        ]
    }
}

enum AnswerStatus {
    case right
    case wrong
}
class GameProgressViewController: UIViewController {
    
    var currentQuestion = 1
    var winningAmount = 0
    private lazy var answerStatus: AnswerStatus = .right
    
    private var prizeTable = PrizeTable.getPrizeTable()
    
    private let millionaireImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resourses.Images.millioneireImage
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextQuestinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Question", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(nextQuestionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Game", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var takeMoneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Take My Money", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(takeMoneyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var progressImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backGroundImage = UIImageView(frame: UIScreen.main.bounds)
        backGroundImage.image = Resourses.Images.bacgroundImage
        backGroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backGroundImage, at: 0)
        
        addViews()
        getStackView()
        layoutViews()
        winningAmount = getWinningAmount(currentQuestion: currentQuestion)
        messageLabel.text = """
Игра окончена!
Твой выигрыш \(winningAmount) руб!
"""
    }
    
    @objc private func nextQuestionButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func newGameButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func takeMoneyButtonPressed() {

        let congratulationVC = CongratulationVC()
        congratulationVC.changeAmount("\(winningAmount)")
        congratulationVC.modalPresentationStyle = .fullScreen
        present(congratulationVC, animated: true)
        
    }
    
    private func getWinningAmount(currentQuestion: Int) -> Int {
        switch answerStatus {
        case .right:
            return prizeTable[15 - currentQuestion].winningSumm
        case .wrong:
            switch currentQuestion {
            case ..<5: return 0
            case 5..<10: return 1000
            case 10...15: return 32000
            default: return 1000000
            }
        }
    }
}

private extension GameProgressViewController {
    
    func addViews() {
        view.addSubview(millionaireImage)
        view.addSubview(progressImageStackView)
    
        switch answerStatus {
        case .right:
            view.addSubview(nextQuestinButton)
            view.addSubview(takeMoneyButton)
        case .wrong:
            view.addSubview(newGameButton)
            view.addSubview(messageLabel)
        }
    }
    
    func layoutViews() {
        
        switch answerStatus {
            
        case .right:
            millionaireImage.translatesAutoresizingMaskIntoConstraints = false
            nextQuestinButton.translatesAutoresizingMaskIntoConstraints = false
            takeMoneyButton.translatesAutoresizingMaskIntoConstraints = false
            progressImageStackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                takeMoneyButton.heightAnchor.constraint(equalToConstant: 40),
                takeMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                takeMoneyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                
                nextQuestinButton.heightAnchor.constraint(equalToConstant: 40),
                nextQuestinButton.leadingAnchor.constraint(equalTo: takeMoneyButton.trailingAnchor, constant: 20),
                nextQuestinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                nextQuestinButton.bottomAnchor.constraint(equalTo: takeMoneyButton.bottomAnchor),
                nextQuestinButton.widthAnchor.constraint(equalTo: takeMoneyButton.widthAnchor),
                
                millionaireImage.heightAnchor.constraint(equalToConstant: 100),
                millionaireImage.widthAnchor.constraint(equalToConstant: 100),
                millionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                millionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                progressImageStackView.topAnchor.constraint(equalTo: millionaireImage.bottomAnchor, constant: 15),
                progressImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                progressImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                progressImageStackView.bottomAnchor.constraint(equalTo: nextQuestinButton.topAnchor, constant: -20)
            ])
        case .wrong:
            millionaireImage.translatesAutoresizingMaskIntoConstraints = false
            newGameButton.translatesAutoresizingMaskIntoConstraints = false
            progressImageStackView.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                newGameButton.heightAnchor.constraint(equalToConstant: 40),
                newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                newGameButton.topAnchor.constraint(equalTo: progressImageStackView.bottomAnchor, constant: -10),
                
                millionaireImage.heightAnchor.constraint(equalToConstant: 100),
                millionaireImage.widthAnchor.constraint(equalToConstant: 100),
                millionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                millionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                progressImageStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
                progressImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                progressImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                progressImageStackView.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -20),
                
                messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                messageLabel.topAnchor.constraint(equalTo: millionaireImage.bottomAnchor, constant: 8),
                messageLabel.heightAnchor.constraint(equalToConstant: 60)
                
            ])
        }
       
    }
    
    private func getStackView() {
        for prize in prizeTable {
            if prize.qwestionNumber < currentQuestion {
                let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSumm: "\(prize.winningSumm) RUB", colorImage: .green)
                progressImageStackView.addArrangedSubview(questionImage)
            } else if prize.qwestionNumber == currentQuestion {
                switch answerStatus {
                case .right:
                    let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSumm: "\(prize.winningSumm) RUB", colorImage: .green)
                    progressImageStackView.addArrangedSubview(questionImage)
                case .wrong:
                    let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSumm: "\(prize.winningSumm) RUB", colorImage: .red)
                    progressImageStackView.addArrangedSubview(questionImage)
                }
            } else {
                let questionImage = ProgressImage(questionNumber: "Вопрос \(prize.qwestionNumber)", winningSumm: "\(prize.winningSumm) RUB", colorImage: prize.color)
                progressImageStackView.addArrangedSubview(questionImage)
            }
        }
    }
}
