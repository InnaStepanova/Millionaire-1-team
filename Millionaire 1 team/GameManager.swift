//
//  GameManager.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 09.02.2023.
//

import Foundation
import AVFoundation

final class GameManager {
    
    enum SoundType: String {
        case chosenAnswer, win, lose, winGame, timerForResponse
    }
    
    private var player: AVAudioPlayer?
    
    let questions = Question.getQuestions()
    
    let optionsLetters = ["A", "B", "C", "D"]

    var levelsCounter = 1
        
    var levelQuestions: [Question] {
        var questionsLevel = [Question]()
        questions.forEach {
            if $0.level == levelsCounter {
                questionsLevel.append($0)
            }
        }
        return questionsLevel
    }
    
    func getCurrentQuestion() -> Question {
        let currentQuestion = levelQuestions[Int.random(in: 0..<levelQuestions.count)]
        return currentQuestion
    }
    
    func playSound(type: SoundType) {
        
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
}
