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
            Form {
                Section() {
                    TextField("Title", text: $name)
                        .fontDesign(.serif)
                    TextField("Description", text: $description)
                        .fontDesign(.serif)
                }
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
