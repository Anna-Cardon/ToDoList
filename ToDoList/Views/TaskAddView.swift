//
//  TaskAddView.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import SwiftUI

struct TaskAddView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var addtaskVM = TaskListViewModel()
    @State private var name: String = "" //name the nature pick

    
    var body: some View {
        NavigationView{
        VStack{
            
            TextField("Task", text: $addtaskVM.taskName)
                .padding(.bottom, 20)
            
            Button("Create Task"){
                addtaskVM.save() { _ in //go to func save
                    dismiss()
                }
            }
            .padding(.top, 30)
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            
            Spacer()
        }
        .padding()
        .navigationTitle("New Task")
        }
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddView()
    }
}
