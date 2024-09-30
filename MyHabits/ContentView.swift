//
//  ContentView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let largeTitle = UIFont.preferredFont(forTextStyle: .largeTitle)
        let descriptor = largeTitle.fontDescriptor.withDesign(.serif)!
        
        let largeFont = UIFont(descriptor: descriptor, size: largeTitle.pointSize)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : largeFont]
    }
    
    @State private var habits: [Habit] = [Habit(title: "Drink water", description: "Drink some water.")]
    
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
            .background(Color(red: 255/255, green: 255/255, blue: 240/255))
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
