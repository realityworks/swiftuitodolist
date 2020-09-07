//
//  TaskCellViewModel.swift
//  TodoList
//
//  Created by Piotr Suwara on 25/8/20.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var task: Task
    
    // Perhaps this isn't the best place?
    @Published var taskRepository = TaskRepository()
    
    // We need to keep the ID when editing so when the task changes it sets this
    var id: String = ""
    
    @Published var completionStateIconName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        // When task is updated, make sure to check the completed flag
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        // Update ID so we don't create new tasks
        $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        // When updated, push it to the task repo
        $task
            .dropFirst() // Not sure I understand why this is here
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task: task)
            }
            .store(in: &cancellables)
    }
}
