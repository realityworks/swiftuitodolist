//
//  Task.swift
//  TodoList (iOS)
//
//  Created by Piotr Suwara on 25/8/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG

let testData = [
    Task(title: "First Task", completed: false),
    Task(title: "Second Task", completed: false),
    Task(title: "Third Task", completed: true),
    Task(title: "First Task", completed: false),
    Task(title: "Second Task", completed: false),
    Task(title: "Third Task", completed: true),
    Task(title: "First Task", completed: false),
    Task(title: "Second Task", completed: false),
    Task(title: "Third Task", completed: true)
]

#endif
