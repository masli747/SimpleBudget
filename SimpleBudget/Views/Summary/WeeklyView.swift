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
    let colors = ["Food": Color.red,
                  "Transport": Color.blue,
                  "Coffee": Color.yellow,
                  "Shopping": Color.green,
                  "Other": Color.purple]
    
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
            // Draw each item from the query as a segment of the pie chart.
            Chart(weeklyData, id: \.category) { item in
                SectorMark(
                  angle: .value("Amount", item.total),
                  innerRadius: .ratio(0.5),
                  outerRadius: .ratio(0.95)
                )
                .annotation(position: .overlay) {
                    Text(item.category)
                        .font(.caption)
                        .bold(true)
                        .foregroundStyle(.white)
                }
                .foregroundStyle(colors[item.category] ?? Color.gray)
            }
            .chartLegend(.visible)
            .navigationTitle("Weekly Breakdown")
            .padding()
        }
    }
}
