//
//  TaskView.swift
//  TodoList
//
//  Created by Piotr Suwara on 25/8/20.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter the task title",
                      text: $taskCellVM.task.title,
                      onCommit: { self.onCommit(self.taskCellVM.task) })
                .padding()
        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(item: testData[2])
//    }
//}
