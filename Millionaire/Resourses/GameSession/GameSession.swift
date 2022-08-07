//
//  GameSession.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import Foundation

struct Hints {
    let callToFriends: Int
    let hallHelp: Int
    let fiftyFifty: Int
}

final class GameSessoin {
    var totalCash: Int = 0
    let totalQuestions: Int = 15
    var answersToQuestions: Int = 0
    let numberOfHints: Hints = Hints(callToFriends: 1, hallHelp: 1, fiftyFifty: 1)
    
}

extension GameSessoin: GameSceneDelegate {
    func didEndGame(withResult result: Int, rightAnswer: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let now = dateFormatter.string(from: Date())
        let newRecord = Records(date: now, totalCash: result, rightAnswers: rightAnswer)
        Game.shared.records.append(newRecord)
    }
    
    
}
