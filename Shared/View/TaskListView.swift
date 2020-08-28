//
//  ContentView.swift
//  Shared
//
//  Created by Piotr Suwara on 25/8/20.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    let tasks = testData
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskView(taskCellVM: taskCellVM)
                    }
                    
                    if presentAddNewItem {
                        TaskView(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                    
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm) {
                SignInWithAppleView()
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.showSignInForm.toggle()
                }, label: {
                    Image(systemName: "person.circle")
                }))
            .navigationTitle("Tasks")
        }
        
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .previewDevice("iPhone 11 Pro")
    }
}
