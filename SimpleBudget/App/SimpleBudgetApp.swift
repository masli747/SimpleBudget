//
//  SimpleBudgetApp.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/15/25.
//

import SwiftUI
import SwiftData

@main
struct SimpleBudgetApp: App {
    // SwiftData container for Expense model
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Expense.self,
            User.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
