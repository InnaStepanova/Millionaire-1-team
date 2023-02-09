//
//  Model.swift
//  Millionaire 1 team
//
//  Created by Лаванда on 07.02.2023.
//

import Foundation

struct Question: Decodable {
    let level: Int
    let ask: String
    let correctAnswer: String
    var wrongAnswers: [String]
    
    static func getQuestions() -> [Question] {
        if let url = Bundle.main.url(forResource: "questions",
                                     withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let questions = try decoder.decode([Question].self,
                                                   from: data)
                return questions
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
    
    func getAllAnswers() -> [String] {
        var allAnswers = wrongAnswers
        allAnswers.insert(correctAnswer,
                          at: Int.random(in: 0..<wrongAnswers.count))
        return allAnswers
    }
    
    func getPrice() -> Int {
        switch level {
        case 1:
            return 0
        case 2:
            return 100
        case 3:
            return 200
        case 4:
            return 300
        case 5:
            return 500
        case 6:
            return 1000
        case 7:
            return 2000
        case 8:
            return 4000
        case 9:
            return 8_000
        case 10:
            return 16_000
        case 11:
            return 32_000
        case 12:
            return 64_000
        case 13:
            return 125_000
        case 14:
            return 250_000
        case 15:
            return 500_000
        default:
            return 1_000_000
        }
    }
}

