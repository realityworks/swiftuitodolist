//
//  TodoListApp.swift
//  Shared
//
//  Created by Piotr Suwara on 25/8/20.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TodoListApp: App {

    // inject into SwiftUI life-cycle via adaptor !!!
     @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
