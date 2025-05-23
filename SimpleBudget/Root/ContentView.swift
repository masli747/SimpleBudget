//
//  ContentView.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: Tab = .root
    
    var body: some View {
        TabView(selection: $selection) {
            DashboardView()
                .tabItem { Label("Dashboard",  systemImage: "house") }
                .tag(Tab.root)
            AddExpenseView()
                .tabItem { Label("Log",        systemImage: "plus.circle") }
                .tag(Tab.expense)
            WeeklyView()
                .tabItem { Label("Weekly",     systemImage: "chart.pie") }
                .tag(Tab.weekly)
            MonthlyView()
                .tabItem { Label("Monthly",    systemImage: "chart.bar") }
                .tag(Tab.monthly)
            DelinquencyView(selectedTab: $selection)
                .tabItem { Label("Delinquency", systemImage: "exclamationmark.triangle") }
                .tag(Tab.delinquency)
            SettingsView()
                .tabItem { Label("Settings",   systemImage: "gear") }
                .tag(Tab.settings)
        }
    }
}

enum Tab {
  case root, dashboard, expense, weekly, monthly, delinquency, settings
}

#Preview {
    ContentView()
}
