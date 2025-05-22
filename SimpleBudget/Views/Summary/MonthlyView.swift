//
//  MonthlyView.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI
import SwiftData
import Charts

struct MonthlyView: View {
    @Query var expenses: [Expense]
    
    var monthlyTotals: [(month: Date, total: Double)] {
        let threeMonthsAgo = Calendar.current.date(
            byAdding: .month, value: -2, to: .now
        )!
        let recent = expenses.filter { $0.date >= threeMonthsAgo }
        let grouped = Dictionary(grouping: recent) {
            Calendar.current.dateInterval(
                of: .month,
                for: $0.date
            )!.start
        }
        return grouped.map { (monthStart, exs) in
            (month: monthStart, total: exs.map(\.amount).reduce(0,+))
        }
        .sorted { $0.month < $1.month }
    }
    
    var body: some View {
        NavigationStack {
            Chart(monthlyTotals, id: \.month) { item in
                BarMark(
                    x: .value("Month", item.month, unit: .month),
                    y: .value("Total", item.total)
                )
            }
            .navigationTitle("Monthly Summary")
            .padding()
        }
    }
}
