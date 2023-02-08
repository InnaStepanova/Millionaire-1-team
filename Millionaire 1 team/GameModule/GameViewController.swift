//
//  ViewController.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 06.02.2023.
//

import UIKit
import AVFoundation

@available(iOS 14.0, *)
final class GameViewController: UIViewController {
    
    enum SoundType: String {
        case backgroundSound, chosenAnswer, win, lose, winGame, timerForResponse
    }
    
    private let questions = Question.getQuestions()
    
    private var levelsCounter = 1
    
    private var player: AVAudioPlayer?
    
    private var timer = Timer()
    
    private var question: Question!
    
    private enum Constants {
        static let winTimeInterval: TimeInterval = 3.5
        static let chosenTime: TimeInterval = 2
        
        static let standartTrailingIndentation: CGFloat = -20
        static let standartLeadingIndentation: CGFloat = 20
        static let stackViewSpacing: CGFloat = 10
        static let answersStackViewHeight: CGFloat = 400
        static let questionViewHeight: CGFloat = 150
    }
    
    private let hints = ["fiftyOnFifty": "forbiddenFiftyOnFifty",
                 "friendCall": "forbiddenFriendCall",
                 "everyoneHelp": "forbiddenEveryoneHelp"]
    
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
        updateUI(with: levelsCounter)
        configureHintsStackView()
        setupUI()
    }
    
    private func configureAnswersStackView(with answers: [String], _ correct: String) {
        
        let optionsLetters = ["A", "B", "C", "D"]
        
        answers.forEach {
            let answerView = AnswerView()
            let optionLetter = optionsLetters[answersStackView.arrangedSubviews.endIndex]
            
            answerView.configure(with: $0, optionLetter, UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                
                self.playSound(type: .chosenAnswer)
                self.answersStackView.isUserInteractionEnabled = false
                
                answerView.updateGradientChosenAnswer()
                
                Timer.scheduledTimer(withTimeInterval: Constants.chosenTime,
                                     repeats: false) { _ in
                    let isRight = self.isRight(userAnswer: answerView.title, correctAnswer: correct)
                    answerView.updateGradient(with: isRight)
                }
            }))
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
                self.updateUI(with: self.levelsCounter)
                self.answersStackView.isUserInteractionEnabled = true
            }
            levelsCounter += 1
            return true
            
        } else {
            playSound(type: .lose)
            print("Game over")
            return false
        }
    }
    
    private func updateUI(with questionLevel: Int) {
        let levelQuestions = getAllLevelQuestion()
        guard let questionNumber = levelQuestions.first?.level else {
            timer.invalidate()
            playSound(type: .winGame)
            print("You're win!")
            return
        }
        
        question = levelQuestions[Int.random(in: 0..<levelQuestions.count)]
        let allAnswers = question.getAllAnswers()
        let priceQuestion = question.getPrice()
        
        questionView.configure(with: question.ask, questionNumber, priceQuestion)
        configureAnswersStackView(with: allAnswers, question.correctAnswer)
        playSound(type: .timerForResponse)
        timerForResponse()
    }
    
    private func cleanAnswers() {
        answersStackView.arrangedSubviews.forEach {
            answersStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    private func getAllLevelQuestion() -> [Question] {
        var questionsLevel = [Question]()
        questions.forEach {
            if $0.level == levelsCounter {
                questionsLevel.append($0)
            }
        }
        return questionsLevel
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
    
    private func configureHintsStackView() {
        for (key, value) in hints {
            let hintButton = UIButton(type: .system)
            hintButton.setImage(UIImage(named: key)?.withRenderingMode(.alwaysOriginal), for: .normal)
            hintButton.setImage(UIImage(named: value)?.withRenderingMode(.alwaysOriginal), for: .selected)
            hintButton.imageView?.contentMode = .scaleAspectFit
            hintButton.tintColor = .clear
            if key == "fiftyOnFifty" {
                hintButton.addAction(UIAction(handler: { _ in
                    if !hintButton.isSelected {
                        hintButton.isSelected.toggle()
                        self.fiftyOnFifty()
                    } else {
                        print("Hint used already")
                    }
                }), for: .touchUpInside)
            } else if key == "friendCall" {
                hintButton.addAction(UIAction(handler: { _ in
                    if !hintButton.isSelected {
                        hintButton.isSelected.toggle()
                        self.friendCall()
                    } else {
                        print("Hint used already")
                    }
                }), for: .touchUpInside)
            } else {
                hintButton.addAction(UIAction(handler: { _ in
                    if !hintButton.isSelected {
                        hintButton.isSelected.toggle()
                        self.everyoneHelp()
                    } else {
                        print("Hint used already")
                    }
                }), for: .touchUpInside)
            }
            hintsStackView.addArrangedSubview(hintButton)
        }
        
    }
    
    private func timerForResponse() {
        progressBar.progress = 0
        var time: Float = 30
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if time > 0 {
                time -= 1
                self.progressBar.progress = 1 - time/30
            } else {
                self.timer.invalidate()
                self.playSound(type: .lose)
                // добавить функцию перехода на экран поражения с задержкой 4 секунды
            }
        })
    }
    
    private func everyoneHelp() {
        if Int.random(in: 1...10) <= 7 {
            let alert = UIAlertController(title: "Everyone help", message: question.correctAnswer, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Everyone help", message: self.question.wrongAnswers[Int.random(in: 0...question.wrongAnswers.count - 1)], preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func friendCall() {
        if Int.random(in: 1...10) <= 8 {
            let alert = UIAlertController(title: "Call a friend", message: question.correctAnswer, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Call a friend", message: self.question.wrongAnswers[Int.random(in: 0...question.wrongAnswers.count - 1)], preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    private func fiftyOnFifty() {
        var buff : [AnswerView] = []
        answersStackView.arrangedSubviews.forEach {
            let a = $0 as! AnswerView
            if a.title != question.correctAnswer {
                buff.append(a)
            }
        }
        buff.shuffle()
        buff.remove(at: 0).fiftyOnFiftySetup()
        buff.remove(at: 0).fiftyOnFiftySetup()
        question.wrongAnswers = [buff[0].title]
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
            progressBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            progressBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

