//
//  HabitManager.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import Foundation

class HabitManager: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            save()
        }
    }
    
    init() {
        let url = URL.documentsDirectory.appending(path: "habits.json")
        
        if let encodedData = try? String(contentsOf: url) {
            if let data = try? JSONDecoder().decode([Habit].self, from: Data(encodedData.utf8)) {
                habits = data
                return
            }
        }
        
        habits = [Habit]()
    }
    
    private func save() {
        guard let encodedData = try? JSONEncoder().encode(habits) else {
            fatalError("Failed to encode habit list to JSON.")
        }
        
        let url = URL.documentsDirectory.appending(path: "habits.json")
        
        do {
            try encodedData.write(to: url)
        } catch {
            fatalError("Failed to write habit list to JSON – \(error.localizedDescription).")
        }
    }
}
