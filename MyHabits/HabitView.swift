//
//  HabitView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct HabitView: View {
    @State var habit: Habit
    
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
                Button("I did it!") {
                    habit.timesCompleted += 1
                }
                .foregroundStyle(.white)
                .padding()
                .background(.darkBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .frame(maxWidth: .infinity)
        }
        .background(.generalBackground)
        .navigationTitle(habit.title)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit(title: "Drink water", description: "Drink some water."))
    }
}
