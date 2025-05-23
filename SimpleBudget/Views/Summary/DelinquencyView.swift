//
//  DelinquencyView.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/22/25.
//

import SwiftUI
import SwiftData

struct DelinquencyView: View {
    @Binding var selectedTab: Tab
    @Environment(\.modelContext) private var context
    @Environment(\.refresh) private var refresh
    @Query var user: [User]
    
    var body: some View {
        Group {
            if let user = user.first {
                Form {
                    Section(header: Text("User")) {
                        TextField("Name", text: .constant(user.name))
                    }
                }
            } else {
                Text("User Not Configured...")
            }
        }
        .onChange(of: selectedTab) {
            Task {
                await refresh?()
            }
        }
    }
}

#Preview {
    DelinquencyView(selectedTab: .constant(.delinquency))
}
