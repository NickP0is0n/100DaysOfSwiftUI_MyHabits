//
//  HabitPreview.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 01.10.2024.
//

import SwiftUI

struct HabitPreview: View {
    let habit: Habit
    
    var body: some View {
        NavigationLink(value: habit) {
            HStack {
                VStack(alignment: .leading) {
                    Text(habit.title)
                        .font(.headline)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                    Text(habit.description)
                        .font(.subheadline)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                HStack {
                    if habit.isDaily {
                        if !Calendar.current.isDate(habit.lastCompleteDate, inSameDayAs: Date.now) {
                            Image(systemName: "x.circle.fill")
                                .foregroundStyle(.red)
                        }
                        else {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text(habit.lastCompleteDate, format: .dateTime.hour().minute())
                                .font(.subheadline.italic())
                                .foregroundStyle(.white)
                        }
                    } else {
                        if habit.timesCompleted < 1 {
                            Image(systemName: "x.circle.fill")
                                .foregroundStyle(.red)
                        }
                        else {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text("^[\(habit.timesCompleted) time](inflect: true)")
                                .font(.subheadline.italic())
                                .foregroundStyle(.white)
                        }
                    }
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
            }
            .padding()
            .background(.darkBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct HabitRemovalPreview: View {
    let habit: Habit
    let onRemove: (() -> Void)
    
    var body: some View {
        Button {
            onRemove()
        } label: {
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
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.white)
            }
            .padding()
            .background(.darkBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct HabitPreview_Previews: PreviewProvider {
    static var previews: some View {
        var test = Habit(title: "Test habit", description: "Test description")
        test.timesCompleted = 5
        return HabitPreview(habit: test)
    }
}
