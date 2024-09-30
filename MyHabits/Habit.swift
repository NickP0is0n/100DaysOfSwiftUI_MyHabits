//
//  Habit.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import Foundation

struct Habit: Codable, Hashable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    
    var timesCompleted = 5
}
