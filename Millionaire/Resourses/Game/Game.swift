//
//  Game.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 05.08.2022.
//

import Foundation

struct Records: Codable {
    var date: String
    var totalCash: Int
    var rightAnswers: Int
}

final class Game {
    static var shared = Game()
    var gameSession: GameSessoin?
    private(set) var records: [Records] = []
    private let recordCaretaker = RecordsCareTaker()
    
    private init() {
        self.records = recordCaretaker.getSaveRecords()
    }
    
    func addRecords(records: Records) {
        self.records.append(records)
    }
    func removeLast() {
        self.records.removeLast()
    }
    func saveRecords() {
        self.recordCaretaker.saveRecords(records: self.records)
    }
    
    
}
