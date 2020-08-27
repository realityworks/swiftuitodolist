//
//  TaskRepository.swift
//  TodoList (iOS)
//
//  Created by Piotr Suwara on 26/8/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var tasks = [Task]()
    init() {
        loadData()
    }
    func loadData() {
        db.collection("tasks")
            .order(by: "createdTime")
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
            _ = try db.collection("tasks").addDocument(from: task)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
}
