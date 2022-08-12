//
//  CreateDifficultyStratigies.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import Foundation

protocol CreateDifficultyStratigies {
    func setGameSceneDifficultyProperty(fromGameScene scene: GameSceneViewController)
}

final class EasyStrategies: CreateDifficultyStratigies {
    func setGameSceneDifficultyProperty(fromGameScene scene: GameSceneViewController) {
        let newQuestions = scene.allQuestions.sorted(by: { $0.difficultyLevel < $1.difficultyLevel })
        scene.allQuestions = newQuestions
        scene.countdown = 60
        scene.gameTime = 60
    }

    
    
}

final class MiddleStrategies: CreateDifficultyStratigies {
 
    func setGameSceneDifficultyProperty(fromGameScene scene: GameSceneViewController) {
        var newQuestions = scene.allQuestions.sorted(by: { $0.difficultyLevel < $1.difficultyLevel })
        while newQuestions.count > 15 {
            newQuestions.removeFirst()
        }
        scene.countdown = 40
        scene.gameTime = 40
    }
    
    
}

final class HardStrategies: CreateDifficultyStratigies {

    func setGameSceneDifficultyProperty(fromGameScene scene: GameSceneViewController) {
        scene.countdown = 30
        scene.gameTime = 30
        let questions = scene.allQuestions.shuffled()
        var newQuestions: [QuestionsModel] = []
        for question in questions {
            let answer = question.answers.shuffled()
            question.answers = answer
            newQuestions.append(question)
        }
        scene.allQuestions = newQuestions
    }
    
    
}
