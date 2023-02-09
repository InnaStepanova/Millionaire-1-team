//
//  ViewController.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit
import AVFoundation

protocol GameViewControllerDelegate {
    func updateGradient(with isRight: Bool)
    func updateGradientChosenAnswer()
}

final class GameViewController: UIViewController {
        
    enum SoundType: String {
        case chosenAnswer, win, lose, winGame, timerForResponse
    }
    
    enum HintType: String, CaseIterable {
        case fiftyOnFifty
        case friendCall
        case everyoneHelp
    }
    
    private let hints = ["fiftyOnFifty": "forbiddenFiftyOnFifty",
                 "friendCall": "forbiddenFriendCall",
                 "everyoneHelp": "forbiddenEveryoneHelp"]
    
    private enum Constants {
        static let winTimeInterval: TimeInterval = 3.5
        static let chosenTime: TimeInterval = 2
        
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewSpacing: CGFloat = 10
        static let answersStackViewHeight: CGFloat = 400
        static let questionViewHeight: CGFloat = 150
    }
    
    private let questions = Question.getQuestions()
    
    private var levelsCounter = 1
    
    private var player: AVAudioPlayer?
    
    private var timer = Timer()
    
    private let gameManager = GameManager()
    
    private var currentQuestion: Question?
    
    private var isGameOver: Bool = false {
        didSet {
            if isGameOver {
                guard let price = currentQuestion?.getPrice() else { return }
                timer.invalidate()
                let vc = GameOverViewController(title: "You are lose.", score: price)
                vc.delegate = self
                present(vc, animated: true)

            } else {
                cleanAnswers()
                cleanHints()
                configureHintsStackView()
                self.answersStackView.isUserInteractionEnabled = true
                gameManager.levelsCounter = 1
                currentQuestion = gameManager.getCurrentQuestion()
                setupUI()
                updateUI(with: gameManager.levelsCounter)

            }
        }
    }
    
    private let backgroundImageView = UIImageView(image: Resourses.Images.bacgroundImage)
    
    private let questionView = QuestionView()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView()
        return progress
    }()
            
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
        updateUI(with: gameManager.levelsCounter)
        configureHintsStackView()
        setupUI()
    }
    
    private func configureAnswersStackView(with answers: [String], _ correct: String) {
        
        answers.forEach {
            let answerView = AnswerView()
            let optionLetter = gameManager.optionsLetters[answersStackView.arrangedSubviews.endIndex]
            
            answerView.configure(with: $0, optionLetter)
            answerView.delegate = self
            
            answersStackView.addArrangedSubview(answerView)
        }
    }
    
    private func isRight(userAnswer: String, correctAnswer: String) -> Bool {
        timer.invalidate()
        if userAnswer == correctAnswer {
            playSound(type: .win)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.winTimeInterval) { [weak self] in
                guard let self = self else { return }
                self.cleanAnswers()
                self.updateUI(with: self.gameManager.levelsCounter)
                self.answersStackView.isUserInteractionEnabled = true
            }
            gameManager.levelsCounter += 1
            return true
            
        } else {
            playSound(type: .lose)
            isGameOver = true
            return false
        }
    }
    
    private func updateUI(with questionLevel: Int) {
        currentQuestion = gameManager.getCurrentQuestion()
        
        guard let currentQuestion = currentQuestion else {
            timer.invalidate()
            playSound(type: .winGame)
            return
        }
        
        questionView.configure(with: currentQuestion.ask,
                               currentQuestion.level,
                               currentQuestion.getPrice())
        
        configureAnswersStackView(with: currentQuestion.getAllAnswers(),
                                  currentQuestion.correctAnswer)
        
        playSound(type: .timerForResponse)
        timerForResponse()
    }
    
    private func cleanAnswers() {
        answersStackView.arrangedSubviews.forEach {
            answersStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func cleanHints() {
        hintsStackView.arrangedSubviews.forEach {
            hintsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func playSound(type: SoundType) {
        
        guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            if let player = player {
                player.play()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc private func hintPressed(_ sender: UIButton) {
        switch sender.currentTitle {
        case "fiftyOnFifty":
            !sender.isSelected ? sender.isSelected.toggle() : print("Hint used already")
            fiftyOnFifty()
            sender.isUserInteractionEnabled = false
        case "friendCall":
            !sender.isSelected ? sender.isSelected.toggle() : print("Hint used already")
            friendCall()
            sender.isUserInteractionEnabled = false
        case "everyoneHelp":
            !sender.isSelected ? sender.isSelected.toggle() : print("Hint used already")
            everyoneHelp()
            sender.isUserInteractionEnabled = false
        default:
            break
        }
    }
    
    private func configureHintsStackView() {
        
        HintType.allCases.forEach {
            let hintButton = UIButton(type: .system)
            hintButton.setImage(UIImage(named: $0.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
            hintButton.setTitle($0.rawValue, for: .normal)
            hintButton.titleLabel?.isHidden = true
            hintButton.imageView?.contentMode = .scaleAspectFit
            hintButton.tintColor = .clear
            hintButton.addTarget(self, action: #selector(hintPressed), for: .touchUpInside)
            switch $0 {
            case .fiftyOnFifty:
                hintButton.setImage(UIImage(named: "forbiddenFiftyOnFifty")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            case .friendCall:
                hintButton.setImage(UIImage(named: "forbiddenFriendCall")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            case .everyoneHelp:
                hintButton.setImage(UIImage(named: "forbiddenEveryoneHelp")?.withRenderingMode(.alwaysOriginal),
                                    for: .selected)
            }
            hintsStackView.addArrangedSubview(hintButton)
        }
    }
    
    private func timerForResponse() {
        progressBar.progress = 0
        var time: Float = 30
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            if time > 0 {
                time -= 1
                self.progressBar.progress = 1 - time/30
            } else {
                self.timer.invalidate()
                self.playSound(type: .lose)
                self.isGameOver = true
            }
        })
    }
    
    private func everyoneHelp() {
        guard let currentQuestion = currentQuestion else { return }
        if Int.random(in: 1...10) <= 7 {
            let alert = UIAlertController(title: "Everyone help", message: currentQuestion.correctAnswer, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Everyone help", message: currentQuestion.wrongAnswers[Int.random(in: 0...currentQuestion.wrongAnswers.count - 1)], preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func friendCall() {
        guard let currentQuestion = currentQuestion else { return }
        if Int.random(in: 1...10) <= 8 {
            let alert = UIAlertController(title: "Call a friend", message: currentQuestion.correctAnswer, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Call a friend", message: currentQuestion.wrongAnswers[Int.random(in: 0...currentQuestion.wrongAnswers.count - 1)], preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func fiftyOnFifty() {
        guard var currentQuestion = currentQuestion else { return }
        var buff : [AnswerView] = []
        answersStackView.arrangedSubviews.forEach {
            let a = $0 as! AnswerView
            if a.title != currentQuestion.correctAnswer {
                buff.append(a)
            }
        }
        buff.shuffle()
        buff.remove(at: 0).fiftyOnFiftySetup()
        buff.remove(at: 0).fiftyOnFiftySetup()
        currentQuestion.wrongAnswers = [buff[0].title]
    }
    
    private func setupUI() {
        let subviews = [backgroundImageView,
                        questionView,
                        answersStackView,
                        hintsStackView,
                        progressBar]
        
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
            hintsStackView.bottomAnchor.constraint(equalTo: progressBar.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.standartLeadingIndentation),
            progressBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.standartTrailingIndentation),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension GameViewController: GameOverViewControllerDelegate {
    func restartGame(isGameOver: Bool) {
        self.isGameOver = isGameOver
    }
}

extension GameViewController: AnswerViewDelegate {
    func answerButtonTapped(with userAnswer: String, answerView: AnswerView) {
        answerView.updateGradientChosenAnswer()
        playSound(type: .chosenAnswer)
        answersStackView.isUserInteractionEnabled = false
        
        Timer.scheduledTimer(withTimeInterval: Constants.chosenTime,
                             repeats: false) { [weak self] _ in
            guard let self = self,
                  let correct = self.currentQuestion?.correctAnswer else { return }
            let isRight = self.isRight(userAnswer: userAnswer, correctAnswer: correct)
            answerView.updateGradient(with: isRight)
        }
    }
}
