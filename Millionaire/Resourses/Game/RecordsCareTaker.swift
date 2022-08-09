//
//  RecordsCareTaker.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 07.08.2022.
//

import Foundation

final class RecordsCareTaker {
    
    private let encopder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "records"
    
    func saveRecords(records: [Records]) {
        do {
            let data = try encopder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        }catch {
            print(error)
        }
    }
    
    func getSaveRecords() -> [Records] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Records].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
