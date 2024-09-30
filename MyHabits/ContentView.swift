//
//  ContentView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    static let habitManager = HabitManager()
    @State private var habits: [Habit] = habitManager.habits
    
    init() {
        let largeTitle = UIFont.preferredFont(forTextStyle: .largeTitle)
        let regularTitle = UIFont.preferredFont(forTextStyle: .body)
        
        let descriptor = largeTitle.fontDescriptor.withDesign(.serif)!
        
        let largeFont = UIFont(descriptor: descriptor, size: largeTitle.pointSize)
        let regularFont = UIFont(descriptor: descriptor, size: regularTitle.pointSize)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : largeFont]
        UINavigationBar.appearance().titleTextAttributes = [.font : regularFont]
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    NavigationLink(value: habit) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.title)
                                    .font(.headline)
                                    .fontDesign(.serif)
                                    .foregroundStyle(Color.white)
                                Text(habit.description)
                                    .font(.subheadline)
                                    .fontDesign(.serif)
                                    .foregroundStyle(Color.white)
                            }
                            Spacer()
                            HStack {
                                if habit.timesCompleted < 1 {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundStyle(.red)
                                }
                                else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                    Text("\(habit.timesCompleted) times")
                                        .font(.subheadline.italic())
                                        .foregroundStyle(Color.white)
                                }
                            }
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .background(.generalBackground)
            .scrollContentBackground(.hidden)
            .navigationTitle("MyHabit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
