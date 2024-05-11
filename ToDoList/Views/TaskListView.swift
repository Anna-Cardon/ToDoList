//
//  TaskListView.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import SwiftUI

struct TaskListView: View {
@State private var isPresented : Bool = false
@ObservedObject private var taskListVM = TaskListViewModel()

var body: some View {
    VStack{
        List(taskListVM.task, id: \.taskName){ //makes a list
            task in
            TaskCell(task: task)
            
        }.listStyle(PlainListStyle())
    }.navigationTitle("To Do list")
        .navigationBarItems(trailing: Button(action:{
            isPresented = true
        } , label: {
            Image(systemName: "plus") //makes a plus button
        }))
        
    .sheet(isPresented: $isPresented, onDismiss:{ //uses published var
        taskListVM.getAllTasksForUser() //get new tasks after adding
    }, content: {
        TaskAddView() //when set to true taskaddview is presented
    })
   
    
    .onAppear(perform: {taskListVM.getAllTasksForUser()})
}
}

struct TaskListView_Previews: PreviewProvider {
static var previews: some View {
    TaskListView()
}
}

struct TaskCell: View {
let task: TaskViewModel
var body: some View {
    VStack(alignment: .leading, spacing: 8){ //aligns
        Text(task.taskName)
            .font(.headline)
    }
}
}
