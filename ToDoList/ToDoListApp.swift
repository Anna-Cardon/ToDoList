//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//connects to firebase

import SwiftUI
import FirebaseCore

@main
struct ToDoListApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
