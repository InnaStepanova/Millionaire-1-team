//
//  GameManager.swift
//  Millionaire 1 team
//
//  Created by Konstantin Grachev on 09.02.2023.
//

import Foundation

final class GameManager {
    
    let questions = Question.getQuestions()
    
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
}
