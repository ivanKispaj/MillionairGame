//
//  QuestionsModel.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import Foundation

final class QuestionsModel: Codable {
    var question: String
    var answers: [String]
    var rightAnswer: String
    var difficultyLevel: Int
    var description: String?
    init(question: String, answers: [String], rightAnswer: String, difficultyLevel: Int, description: String? = nil) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
        self.difficultyLevel = difficultyLevel
        self.description = description
    }
}



