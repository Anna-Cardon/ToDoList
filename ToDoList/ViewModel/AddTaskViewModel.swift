//
//  AddTaskViewModel.swift
//  ToDoList
//
//  Created by Anna on 5/12/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseFirestore

class ToDoList: ObservableObject{//this is the bit that connects to the firestore
    
    private var db: Firestore
    
    init(){
        db = Firestore.firestore() //connect to firestore
    }
    
    
    func deleteTask(taskId: String, completion: @escaping (Error?)->Void){
        
        db.collection("tasks")
            .document(taskId)
            .delete{
                (error) in
                completion(error)
            }
    }

    func getTaskId(taskId: String, completion: @escaping (Result<Tasks?, Error>)-> Void){
        
        let ref = db.collection("tasks").document(taskId)//reference
        ref.getDocument {(snapshot, error) in //get whats inside the collection
                if let error = error { //if you cant then error
                    completion(.failure(error))
                }else{
                    if let snapshot = snapshot { //if you can
                        var task: Tasks? = try? snapshot.data(as: Tasks.self)
                            if task != nil{
                                task!.id = snapshot.documentID
                                completion(.success(task))
                            }
                        }
                    }
                }
    }
    
    func getAllTasks (completion: @escaping (Result<[Tasks]?, Error>) -> Void){ //get tasks, returns array of tasks or an error
        
        db.collection("tasks")//connect to firebase collection called stores
            .getDocuments(completion: {(snapshot, error) in //get whats inside the collection
                if let error = error { //if you cant then error
                    completion(.failure(error))
                }else{
                    if let snapshot = snapshot { //if you can
                        let task: [Tasks]? = snapshot.documents.compactMap{ //make a var hold the task array
                            doc in
                            var task = try? doc.data(as: Tasks.self)
                            if task != nil{
                                task!.id = doc.documentID
                            }
                            return task
                        }
                        completion(.success(task))
                    }
                }
            })
    }
    
    func save(task: Tasks, completion: @escaping (Result<Tasks?, Error>) -> Void){
        //func to save tasks
        do{
            let ref = try db.collection("tasks").addDocument(from: task) //try to add new doc if not already there called tasks
                ref.getDocument { (snapshot, error) in //get doc and return whats inside
                guard let snapshot = snapshot, error == nil else{ //if it doesn't work say failure and return
                    completion(.failure(error!))
                    return
                }
                //if it does work come down here and store what we want into the doc tasks
                    let task = try? snapshot.data(as: Tasks.self)
                completion(.success(task))//completion handler giving us the saved task
            }
        }catch let error { //another way to say the do didn't work
            completion(.failure(error))
        }
    }
}
