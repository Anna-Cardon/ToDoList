//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import Foundation
struct TaskViewModel {
    let task : Tasks
    
    var taskId: String{
        task.id ?? ""
    }
    
    var taskName: String{
        task.task
    }
}
