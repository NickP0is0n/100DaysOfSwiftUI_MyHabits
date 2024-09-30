//
//  ContentView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habitManager = HabitManager()
    
    @State private var isAddHabitSheetShown = false
    
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
                ForEach(habitManager.habits) { habit in
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
                .onDelete(perform: removeRows)
                .listRowBackground(Color.darkBackground)
            }
            .scrollContentBackground(.hidden)
            .background(.generalBackground)
            .navigationTitle("MyHabit")
            .toolbar {
                Button {
                    isAddHabitSheetShown = true
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                            .fontDesign(.serif)
                    }
                }
                .foregroundStyle(.primary)
            }
            .sheet(isPresented: $isAddHabitSheetShown) {
                AddHabitView(habitManager: habitManager)
            }
            .navigationDestination(for: Habit.self) { selection in
                HabitView(habit: selection, habitManager: habitManager)
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        habitManager.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
