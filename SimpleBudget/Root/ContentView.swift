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
    @State private var reloadUserTab = UUID()
    
    var body: some View {
        // Present navigatable scenes to the user.
        TabView(selection: $selection) {
            DashboardView()
                .tabItem { Label("Dashboard",  systemImage: "house") }
                .tag(Tab.root)
            WeeklyView()
                .tabItem { Label("Weekly",     systemImage: "chart.pie") }
                .tag(Tab.weekly)
            MonthlyView()
                .tabItem { Label("Monthly",    systemImage: "chart.bar") }
                .tag(Tab.monthly)
            DelinquencyView(selectedTab: $selection)
                .id(reloadUserTab)
                .tabItem { Label("Risk", systemImage: "exclamationmark.triangle") }
                .tag(Tab.delinquency)
            SettingsView()
                .tabItem { Label("Settings",   systemImage: "gear") }
                .tag(Tab.settings)
            ExportView()
                .tabItem { Label("Export", systemImage: "externaldrive.badge.timemachine") }
                .tag(Tab.export)
        }
    }
}

// Keep track of where the user is in the navigation stack.
enum Tab {
    case root, dashboard, expense, weekly, monthly, delinquency, settings, export
}

#Preview {
    ContentView()
}
