//
//  Game.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import Foundation

final class Game {
    static var shared = Game()
    var gameSession: GameSessoin?
    var records: [Records] = []
    private init() {
        
    }
}
