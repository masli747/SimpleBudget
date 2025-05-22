//
//  WeeklyView.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import SwiftUI
import SwiftData
import Charts

struct WeeklyView: View {
    @Query var expenses: [Expense]
    
    var weeklyData: [(category: String, total: Double)] {
        let weekAgo = Calendar.current.date(
            byAdding: .day, value: -6, to: .now
        )!
        let recent = expenses.filter { $0.date >= weekAgo }
        let grouped = Dictionary(
            grouping: recent,
            by: \.category
        )
        return grouped.map { (cat, exs) in
            (category: cat, total: exs.map(\.amount).reduce(0,+))
        }
    }
    
    var body: some View {
        NavigationStack {
            Chart(weeklyData, id: \.category) { item in
                SectorMark(
                    angle: .value("Amount", item.total)
                )
                .annotation(position: .automatic) { //.annotation(position: .center)
                    Text(item.category)
                        .font(.caption)
                }
            }
            .chartLegend(.visible)
            .navigationTitle("Weekly Breakdown")
            .padding()
        }
    }
}
