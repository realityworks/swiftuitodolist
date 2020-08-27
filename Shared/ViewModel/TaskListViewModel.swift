//
//  TaskListViewModel.swift
//  TodoList
//
//  Created by Piotr Suwara on 25/8/20.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels: [TaskCellViewModel] = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.loadData()
        taskRepository.$tasks.map { tasks in
                tasks.map { TaskCellViewModel(task: $0) }
            }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addTask(task: Task) {
        taskRepository.add(task: task)
//        let taskVM = TaskCellViewModel(task: task)
//        taskCellViewModels.append(taskVM)
    }
}
