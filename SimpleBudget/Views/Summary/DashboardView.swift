//
//  DashboardView.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \Expense.date, order: .reverse) var expenses: [Expense]
    @State private var showAlert = false
    @State private var stackPath = NavigationPath()
    
    // Usability: visibility of system status
    var todayTotal: Double {
        let start = Calendar.current.startOfDay(for: .now)
        return expenses
            .filter { $0.date >= start }
            .map(\.amount)
            .reduce(0, +)
    }
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            VStack(spacing: 20) {
                Text("Today’s Spend")
                    .font(.headline)
                Text(todayTotal, format: .currency(code: Settings.currency))
                    .font(.largeTitle) // legible typography
                List {
                    ForEach(expenses.filter {
                        $0.date >= Calendar.current.startOfDay(for: .now)
                    }) { exp in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(exp.category)
                                Text(exp.note ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(exp.amount, format: .currency(code: Settings.currency))
                        }
                        .contentShape(Rectangle()) // ≥44pt tap area
                    }
                }
                .navigationDestination(for: String.self) { _ in
                AddExpenseView()
                } // Configure title, add, and edit buttons.
//                .navigationTitle(Text("RealAssignments\u{2122}"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AddExpenseView()
                        } label: {
                            HStack {
                                Image(systemName: "plus")
//                                Text("Log")
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
