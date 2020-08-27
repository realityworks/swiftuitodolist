//
//  TaskRepository.swift
//  TodoList (iOS)
//
//  Created by Piotr Suwara on 26/8/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var tasks = [Task]()
    init() {
        loadData()
    }
    func loadData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot {
                self.tasks = snapshot.documents.compactMap { document in
                    try? document.data(as: Task.self)
                }
            }
        }
    }
    func add(task: Task) {
        do {
            var userIdTask = task
            userIdTask.userId = Auth.auth().currentUser?.uid
            try db.collection("tasks").addDocument(from: userIdTask)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    func updateTask(task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
}
