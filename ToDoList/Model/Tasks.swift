//
//  Tasks.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import Foundation
struct Tasks: Codable{
    var id: String? //doc id for the task
    var task: String = "" //name given to the task
    var userId: String = "" //which user added this task

}
