//
//  CreateDifficultyStratigies.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import Foundation

protocol CreateDifficultyStratigies {
    func setTimesToQuestion() -> Int
    func setOrderOfQuestions(from questions: [QuestionsModel]) -> [QuestionsModel]
}

final class EasyStrategies: CreateDifficultyStratigies {
    func setTimesToQuestion() -> Int {
        return 60
    }
    
    func setOrderOfQuestions(from questions: [QuestionsModel]) -> [QuestionsModel] {
        return questions.sorted(by: { $0.difficultyLevel < $1.difficultyLevel })
    }
    
    
}

final class MiddleStrategies: CreateDifficultyStratigies {
    func setTimesToQuestion() -> Int {
        return 40
    }
    
    func setOrderOfQuestions(from questions: [QuestionsModel]) -> [QuestionsModel] {
        var newQuestions = questions.sorted(by: { $0.difficultyLevel < $1.difficultyLevel })
        
        while newQuestions.count > 15 {
            newQuestions.removeFirst()
        }
        return newQuestions
    }
    
    
}

final class HardStrategies: CreateDifficultyStratigies {
    func setTimesToQuestion() -> Int {
        return 30
    }
    
    func setOrderOfQuestions(from questions: [QuestionsModel]) -> [QuestionsModel] {
        let newQuestions = questions.shuffled()
        var returnQuestions: [QuestionsModel] = []
        for question in newQuestions {
            let answer = question.answers.shuffled()
            question.answers = answer
            returnQuestions.append(question)
        }
        return returnQuestions
    }
    
    
}
