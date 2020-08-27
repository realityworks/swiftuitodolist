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
    @Published var taskRepository = TaskRepository()
    
    var id: String = ""
    
    @Published var completionStateIconName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            .dropFirst() // Not sure I understand why this is here
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task: task)
            }
            .store(in: &cancellables)
    }
}
