//
//  Settings.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI
import SwiftData

struct Settings {
    @AppStorage("currency") static var currency = "USD"
    @AppStorage("user_configured") static var userConfigured: Bool = false
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var stackPath = NavigationPath()
    @AppStorage("currency") private var currency = "USD"
    let options = ["USD","EUR","KRW"]
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            Form {
                Section("Currency") {
                    Picker("Currency", selection: $currency) {
                        ForEach(options, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    NavigationLink {
                        UserConfiguration()
                    } label: {
                        ListCell(message: "Configure User")
                    }
                }
                Section {
                    Button("Reset All Data") {
                        // Usability: user control & freedom
                        deleteAll()
                    }
                    .foregroundStyle(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func deleteAll() {
        // simply reset app data
        UserDefaults.standard.removeObject(forKey: "currency")
        resetData()
        dismiss()
    }
    
    // Violentely remove all tuples from the database.
    private func resetData() {
        do {
            try context.delete(model: User.self)
            try context.delete(model: Expense.self)
        } catch {
            print("Error deleting all data: \(error)")
        }
    }
}

// Simple structure to organize presenting a navigation link to the user.
struct ListCell: View {
    var message: String
    
    var body: some View {
        HStack {
            Text(message)
        }
    }
}
