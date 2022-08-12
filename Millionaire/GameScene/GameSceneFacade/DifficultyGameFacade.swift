//
//  DifficultyGameFacade.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import Foundation


final class DifficultyGameFacade {
    private var difficulty: DifficultyLevel
    
    private var difficultyStrategy: CreateDifficultyStratigies {
        switch difficulty {
        case .easy:
            return EasyStrategies()
        case .middle:
            return MiddleStrategies()
        case .hard:
            return HardStrategies()
        }
    }
    
    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
    }
    
    func setLevelDifficulty(fromGameScene scene: GameSceneViewController) {
        difficultyStrategy.setGameSceneDifficultyProperty(fromGameScene: scene)
    }
}
