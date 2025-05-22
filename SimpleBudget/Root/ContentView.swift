//
//  ContentView.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard",  systemImage: "house") }
            AddExpenseView()
                .tabItem { Label("Log",        systemImage: "plus.circle") }
            WeeklyView()
                .tabItem { Label("Weekly",     systemImage: "chart.pie") }
            MonthlyView()
                .tabItem { Label("Monthly",    systemImage: "chart.bar") }
            SettingsView()
                .tabItem { Label("Settings",   systemImage: "gear") }
        }
    }
}


#Preview {
    ContentView()
}
