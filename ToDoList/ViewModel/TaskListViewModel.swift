//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

enum LoadingState {
    case idle
    case loading
    case success
    case failure
}

class TaskListViewModel: ObservableObject {
    
    let storage = Storage.storage() //connect to storage of certain user
    let db = Firestore.firestore() //connect to our firestore database
    @Published var task : [TaskViewModel] = [] //as soon as assign refreshes and shows users tasks as an array
    @Published var loadingState : LoadingState = .idle //not active at first
    @Published var saved: Bool = false //because its @published, when called it'll generate an event and our UI or view can hook up to the event and display some information, like saving a store just added or below saying can't save store
    var taskName: String = ""
    
    
    
    func getAllTasksForUser () { //works
        
        DispatchQueue.main.async {
            self.loadingState = .loading //we are now trying to get images
        }
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        
        db.collection("ToDoList") //create a collection called todolist in server
            .whereField("userId", isEqualTo: currentUser.uid) //current logged in user
                        /* for a understanding on weak self read: https://matteomanferdini.com/swift-weak-self/ */
            .getDocuments{[weak self](snapshot, error) in //get whats inside the collection
                if let error = error { //if you cant then error
                    print(error.localizedDescription) //tell us why
                    DispatchQueue.main.async {
                        self?.loadingState = .failure //update loading state
                    }
                }else{
                    if let snapshot = snapshot {
                    let task: [TaskViewModel] = /*assign array values */
                    /* to understand compactMaps: https://www.hackingwithswift.com/example-code/language/how-to-use-compactmap-to-transform-an-array */
                        snapshot.documents.compactMap{
                        doc in
                        var task = try? doc.data(as: Tasks.self)
                        task?.id = doc.documentID
                        if let task = task{ //if the task belongs to our user send it to taskviewmodel
                        return TaskViewModel(task: task)
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        self?.task = task
                        self?.loadingState = .success
                    }
                    }
                    
                            }
                        }
                    }
                
            
    
    
                                    
func save(completion: (Error?)->Void){
    
    guard let currentUser = Auth.auth().currentUser else{
        return
    }
    do{
        let _ = try db.collection("ToDoList") //try to make the _ connect to our task database collection
            .addDocument(from: Tasks(task: taskName, userId: currentUser.uid))
         completion(nil)//complete with no error
    }catch let error {
        completion (error) //there's a error
    }
}
}
    

