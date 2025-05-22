//
//  Settings.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI

struct Settings {
    @AppStorage("currency") static var currency = "USD"
}

struct SettingsView: View {
    @AppStorage("currency") private var currency = "USD"
    let options = ["USD","EUR","KRW"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Currency") {
                    Picker("Currency", selection: $currency) {
                        ForEach(options, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
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
    }
}

