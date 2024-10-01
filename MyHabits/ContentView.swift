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
    @State private var isEditModeEnabled = false
    
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
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(habitManager.habits) { habit in
                        if isEditModeEnabled {
                            HabitRemovalPreview(habit: habit) {
                                guard let index = habitManager.habits.firstIndex(of: habit) else {
                                    fatalError("This activity wasn't found in habit manager.")
                                }
                                withAnimation {
                                    habitManager.habits.remove(at: index)
                                }
                            }
                        }
                        else {
                            HabitPreview(habit: habit)
                        }
                    }
                }
                .padding()
                .navigationTitle("MyHabit")
                .toolbar {
                    if !isEditModeEnabled {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                isAddHabitSheetShown = true
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                }
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                isEditModeEnabled.toggle()
                            }
                        } label: {
                            if isEditModeEnabled {
                                Text("Done")
                                    .fontDesign(.serif)
                            }
                            else {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                    
                }
                .sheet(isPresented: $isAddHabitSheetShown) {
                    AddHabitView(habitManager: habitManager)
                }
                .navigationDestination(for: Habit.self) { selection in
                    HabitView(habit: selection, habitManager: habitManager)
                }
            }
            .background(.generalBackground)
            .preferredColorScheme(.light)
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
