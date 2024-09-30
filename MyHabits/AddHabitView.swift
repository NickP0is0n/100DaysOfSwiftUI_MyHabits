//
//  AddHabitView.swift
//  MyHabits
//
//  Created by Mykola Chaikovskyi on 30.09.2024.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    let habitManager: HabitManager
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section() {
                        TextField("Title", text: $name)
                            .fontDesign(.serif)
                        TextField("Description", text: $description)
                            .fontDesign(.serif)
                    }
                }
                .padding(.bottom)
                
                Text("Starting a new habit is a powerful moment. It’s more than just a decision—it’s the beginning of a journey toward growth and self-improvement. When you add a new habit to track, you're planting the seed for meaningful change in your life. The simple act of acknowledging what you want to improve is the first step in making that vision a reality."
                )
                .padding()
                .font(.body)
                .fontDesign(.serif)
                .foregroundStyle(.secondary)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        habitManager.habits.append(Habit(title: name, description: description))
                        dismiss()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.generalBackground)
        }
        
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habitManager: HabitManager())
    }
}
