//
//  QuestionsModel.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import Foundation

final class QuestionsModel: Codable {
    let question: String
    var answers: [String]
    let rightAnswer: String
    let difficultyLevel: Int
    let description: String?
    init(question: String, answers: [String], rightAnswer: String, difficultyLevel: Int, description: String?) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
        self.difficultyLevel = difficultyLevel
        self.description = description
    }
}



