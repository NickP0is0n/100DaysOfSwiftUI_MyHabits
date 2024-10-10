//
//  Habit.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import Foundation

struct Habit: Codable, Hashable, Equatable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    
    var isDaily = false
    var lastCompleteDate = Date(timeIntervalSince1970: 0)
    
    var timesCompleted = 0
}
