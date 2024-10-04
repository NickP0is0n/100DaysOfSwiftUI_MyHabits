//
//  HabitView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct HabitView: View {
    @State var habit: Habit
    @State private var taskCompletedPressed = false
    
    let habitManager: HabitManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(habit.description)
                    .font(.body)
                    .fontDesign(.serif)
                
                HStack {
                    if habit.timesCompleted <= 0 {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.red)
                        Text("You have not completed your task yet!")
                            .font(.headline)
                            .fontDesign(.serif)
                            .foregroundStyle(.red)
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Text("You have completed the task \(habit.timesCompleted) times!")
                            .font(.headline)
                            .fontDesign(.serif)
                    }
                }
                .padding(.top)
                
                Text("Already completed the task?")
                    .font(.subheadline)
                    .fontDesign(.serif)
                    .padding(.top)
                
                HStack {
                    Button("I did it!") {
                        guard let index = habitManager.habits.firstIndex(of: habit) else {
                            fatalError("This activity wasn't found in habit manager.")
                        }
                        habit.timesCompleted += 1
                        habitManager.habits[index] = habit
                        withAnimation {
                            taskCompletedPressed = true
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(.darkBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    if taskCompletedPressed { // to display it
                        Button("Revert") {
                            if taskCompletedPressed { // it disappears, do not do anything
                                guard let index = habitManager.habits.firstIndex(of: habit) else {
                                    fatalError("This activity wasn't found in habit manager.")
                                }
                                habit.timesCompleted -= 1
                                habitManager.habits[index] = habit
                                withAnimation {
                                    taskCompletedPressed = false
                                }
                            }
                        }
                        .foregroundStyle(.darkBackground)
                        .padding()
                        .background(.lightBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .background(.generalBackground)
        .navigationTitle(habit.title)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        let habitManager = HabitManager()
        var test = Habit(title: "Test habit", description: "Test description")
        test.timesCompleted = 5
        return HabitView(habit: test, habitManager: habitManager)
    }
}
