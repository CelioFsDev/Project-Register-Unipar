//
//  Project_Register_UniparApp.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 16/09/22.
//

import SwiftUI
import Firebase

@main
struct Project_Register_UniparApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
