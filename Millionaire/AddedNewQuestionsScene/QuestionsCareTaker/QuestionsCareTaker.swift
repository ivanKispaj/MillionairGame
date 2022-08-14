//
//  QuestionsCareTaker.swift
//  Millionaire
//
//  Created by Ivan Konishchev on 12.08.2022.
//

import Foundation

final class QuestionsCareTaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "questions"
    
    func saveQuestions(questions: [QuestionsModel]) {
        do {
            let data = try encoder.encode(questions)
            UserDefaults.standard.set(data,forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadQuestions() -> [QuestionsModel]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return  try decoder.decode([QuestionsModel].self, from: data)
        } catch {
            print(error)
            return nil
        }
        
    }
}
