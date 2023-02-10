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

protocol GameProgressViewControllerDelegate: AnyObject {
    func restartGame()
    func continueGame()
}

class GameProgressViewController: UIViewController {
    
    weak var delegate: GameProgressViewControllerDelegate?
    
    var currentQuestion = 1
    var winningAmount = 0
    
    var answerStatus: AnswerStatus = .right
    
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
        let button = UIButton(type: .system)
        button.setTitle("Next Question", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 18)
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(nextQuestionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 25)
        button.setTitle("New Game", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var takeMoneyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take My Money", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 18)
        button.setTitleColor(UIColor.white, for: .normal)
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
    
    init(currentQuestion: Int = 1,
         answerStatus: AnswerStatus = .right) {
        self.currentQuestion = currentQuestion
        self.answerStatus = answerStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        if answerStatus == .right {
            messageLabel.text =
"""
Твой выигрыш \(winningAmount) руб!
"""
        } else {
            messageLabel.text =
"""
ИГРА ОКОНЧЕНА!
Твой выигрыш \(winningAmount) руб!
"""
        }
    }
    
    @objc private func nextQuestionButtonPressed() {
        delegate?.continueGame()
        dismiss(animated: true)
    }
    
    @objc private func newGameButtonPressed() {
        delegate?.restartGame()
        dismiss(animated: true)
    }
    
    @objc private func takeMoneyButtonPressed() {

        let congratulationVC = CongratulationVC()
        congratulationVC.delegate = self
        congratulationVC.changeAmount("\(winningAmount)")
        congratulationVC.modalPresentationStyle = .fullScreen
        present(congratulationVC, animated: true) {
            
        }
        
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
        view.addSubview(messageLabel)
    
        switch answerStatus {
        case .right:
            view.addSubview(nextQuestinButton)
            view.addSubview(takeMoneyButton)
        case .wrong:
            view.addSubview(newGameButton)
        }
    }
    
    func layoutViews() {
        millionaireImage.translatesAutoresizingMaskIntoConstraints = false
        progressImageStackView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            millionaireImage.heightAnchor.constraint(equalToConstant: 100),
            millionaireImage.widthAnchor.constraint(equalToConstant: 100),
            millionaireImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            millionaireImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressImageStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            progressImageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            progressImageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: millionaireImage.bottomAnchor, constant: 8),
            messageLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        switch answerStatus {
        case .right:
            takeMoneyButton.translatesAutoresizingMaskIntoConstraints = false
            nextQuestinButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                takeMoneyButton.heightAnchor.constraint(equalToConstant: 40),
                takeMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                takeMoneyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                takeMoneyButton.topAnchor.constraint(equalTo: progressImageStackView.bottomAnchor, constant: 20),
                
                nextQuestinButton.heightAnchor.constraint(equalToConstant: 40),
                nextQuestinButton.leadingAnchor.constraint(equalTo: takeMoneyButton.trailingAnchor, constant: 20),
                nextQuestinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                nextQuestinButton.bottomAnchor.constraint(equalTo: takeMoneyButton.bottomAnchor),
                nextQuestinButton.widthAnchor.constraint(equalTo: takeMoneyButton.widthAnchor),
            ])
        case .wrong:
            newGameButton.translatesAutoresizingMaskIntoConstraints = false
    
            NSLayoutConstraint.activate([
                newGameButton.heightAnchor.constraint(equalToConstant: 40),
                newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                newGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                newGameButton.topAnchor.constraint(equalTo: progressImageStackView.bottomAnchor, constant: 20),
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

extension GameProgressViewController: CongratulationVCDelegate {
    
    func restartFromCongrats(dismiss: Void) {
        delegate?.restartGame()
        self.dismiss(animated: true)
        dismiss
    }
}
