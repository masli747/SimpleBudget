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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Expense.self)
        }
    }
}
