//
//  DelinquencyView.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/22/25.
//

import SwiftUI
import SwiftData

struct DelinquencyView: View {
    @Environment(\.modelContext) private var context
    @Query var user: [User]
    
    var body: some View {
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
}

#Preview {
    DelinquencyView()
}
