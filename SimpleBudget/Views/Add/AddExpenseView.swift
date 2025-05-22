//
//  AddExpenseView.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI
import SwiftData
import UserNotifications

struct AddExpenseView: View {
    @Environment(\.modelContext) private var context
    @State private var amountText = ""
    @State private var category = "Food"
    @State private var note = ""
    @State private var showSaved = false
    
    let categories = ["Food", "Transport", "Coffee", "Shopping", "Other"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", text: $amountText)
                        .keyboardType(.decimalPad)
                }
                Section {
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { Text($0) }
                    }
                }
                Section {
                    TextField("Note (optional)", text: $note)
                }
                Button("Save Expense") {
                    save()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, minHeight: 44) // ≥44pt height
            }
            .navigationTitle("Log Expense")
            .alert("Saved!", isPresented: $showSaved) { }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound]
            ) { _, _ in }
        }
    }
    
    private func save() {
        guard let amt = Double(amountText) else { return }
        let exp = Expense(amount: amt, category: category, note: note)
        context.insert(exp)
        try? context.save()
        showSaved = true
        amountText = ""
        note = ""
        scheduleThresholdAlert()
    }
    
    private func scheduleThresholdAlert() {
        // optional: if todayTotal > X, send notification
        let content = UNMutableNotificationContent()
        content.title = "Good job!"
        content.body = "Expense logged."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(req)
    }
}
