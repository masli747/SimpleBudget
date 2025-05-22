//
//  UserConfiguration.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/22/25.
//

import SwiftUI
import SwiftData

struct UserConfiguration: View {
    @Environment(\.modelContext) private var context
    @Query var user: [User]
    @State private var name: String = ""
    @State private var age: Int = 1
    
    var body: some View {
        if let user = user.first {
            Form {
                Section(header: Text("User")) {
                    TextField("Name", text: .constant(user.name))
                }
            }
        } else {
            Form {
                Section(header: Text("User Information")) {
                    TextField("Name", text: $name)
                    VStack {
                        Text("Select Age:")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("Select Age", selection: $age) {
                            ForEach(1..<101, id: \.self) { age in
                                Text("\(age)").tag(age)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 125)
                    }
                }
                Section(header: Text("Financial Information")) {
                    
                }
            }
        }
        //            .navigationTitle("Configure User")
    }
}

#Preview {
    UserConfiguration()
}
