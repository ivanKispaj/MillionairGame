//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import UIKit

final class QuestionBuilder {
    
    private(set) var question: String = "Введите ваш вопрос..."
    private(set) var answers: [String] = []
    private(set) var description: String? = "Введите описание ответа, если есть..."
    private(set) var difficultyLevel: Int = 0
    private(set) var rightAnswer: String = ""
    private(set) var allQuestions: [QuestionsModel]
    private(set) var allAddedQuestions: [QuestionsModel] = []
    
    init() {
        if let allQuestions = QuestionsCareTaker().loadQuestions() {
            self.allQuestions = allQuestions

        } else {
            self.allQuestions = []
          
        }
        self.allAddedQuestions = [QuestionsModel(question: question, answers: answers, rightAnswer: rightAnswer, difficultyLevel: difficultyLevel, description: description)]
    }
    
    func build() -> Bool {
        for question in self.allAddedQuestions {
            guard question.question != "Введите ваш вопрос...", question.answers.count == 4, question.difficultyLevel != 0, question.rightAnswer != "" else {
                return false
            }
        }
       
        allQuestions = allQuestions + allAddedQuestions
        
        
        return true
    }
    
    func setQuestion(toCell row: Int, _ question: String) {
        self.allAddedQuestions[row].question = question
    }
    
    func setAnswers(toCell row: Int, _ answers: String) {
        let answersArray = answers.components(separatedBy: ",")
        self.allAddedQuestions[row].answers = answersArray
    }
    
    func setDescription(toCell row: Int, _ description: String) {
        self.allAddedQuestions[row].description = description
    }
    
    func setRightAnswer(toCell row: Int, _ rightAnswerNumber: Int) {
        if allAddedQuestions[row].answers.count >= 4 {
            self.allAddedQuestions[row].rightAnswer = allAddedQuestions[row].answers[rightAnswerNumber - 1]
        }
    }
    
    func setDifficulty(toCell row: Int, _ difficulty: Int) {
        self.allAddedQuestions[row].difficultyLevel = difficulty
    }
    
    func getRightQuestionNumber(toCell row: Int) -> Int{
        
        var number = 1
        for answer in allAddedQuestions[row].answers {
            if answer == self.rightAnswer {
                break
            }
            number += 1
        }
        return  number
    }
}

