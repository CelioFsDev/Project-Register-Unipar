//
//  Project_Register_UniparApp.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 16/09/22.
//

import SwiftUI

@main
struct Project_Register_UniparApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
