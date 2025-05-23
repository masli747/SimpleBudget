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
    @Environment(\.dismiss) private var dismiss
    @Query var user: [User]
    @State var name: String = ""
    @State var age: Int = 1
    @State var rev_util: Double = 0
    @State var late_30_59: Int = 0
    @State var debt_ratio: Double = 0
    @State var monthly_inc: Double = 0
    @State var open_credit: Int = 0
    @State var late_90: Int = 0
    @State var real_estate: Int = 0
    @State var late_60_89: Int = 0
    @State var dependents: Int = 0
    @State var delinquency_likelyhood: Double = 0
    
    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                VStack {
                    Text("Enter Name:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Name", text: $name)
                }
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
                VStack {
                    Text("Revolving Utilization:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Revolving Utilization", value: $rev_util, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                    //                            .background(Color.gray)
                }
                VStack {
                    Text("Debt to Income Ratio:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Debt to Income Ratio):", value: $debt_ratio, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Payments Late (30-59 days):")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Payments Late (30-59 days):", value: $late_30_59, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Payments Late (60-89 days):")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Late Payments (60-89 days):", value: $late_60_89, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Payments Late (90+ days):")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Payments Late (90+ Days):", value: $late_90, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Monthly Income:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Monthly Income:", value: $monthly_inc, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Open Credit:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Open Credit:", value: $open_credit, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Real Estate (Properties Owned):")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Real Estate (Properties Owned):", value: $real_estate, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
                VStack {
                    Text("Number of Dependents:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Number of Dependents:", value: $dependents, formatter: Self.formatter)
                        .keyboardType(.numberPad)
                }
            }
            Section(header: Text("Save Changes")) {
                if let user = user.first {
                    Button(action: updateUser) {
                        Text("Update User")
                    }
                } else {
                    Button(action: addUser) {
                        Text("Create User")
                    }
                }
            }
        }
        .onAppear {
            // If valid user already exists, read in their attributes.
            if let existingUser = user.first {
                name = existingUser.name
                age = existingUser.age
                rev_util = existingUser.rev_util
                late_30_59 = existingUser.late_30_59
                debt_ratio = existingUser.debt_ratio
                monthly_inc = existingUser.monthly_inc
                open_credit = existingUser.open_credit
                late_90 = existingUser.late_90
                real_estate = existingUser.real_estate
                late_60_89 = existingUser.late_60_89
                dependents = existingUser.dependents
                delinquency_likelyhood = existingUser.delinquency_likelyhood
            }
        }
        .navigationTitle("Configure User")
    }
    
    func addUser() {
        if let user = user.first {
            updateUser()
            return
        } else {
            let newUser = User(
                name: name,
                rev_util: rev_util,
                age: age,
                late_30_59: late_30_59,
                debt_ratio: debt_ratio,
                monthly_inc: monthly_inc,
                open_credit: open_credit,
                late_90: late_90,
                real_estate: real_estate,
                late_60_89: late_60_89,
                dependents: dependents,
                delinquency_likelyhood: delinquency_likelyhood
            )
            
            context.insert(newUser)
            
            do {
                try context.save()
                dismiss()
            } catch {
                print("Failed to save new user:", error)
            }
        }
    }
    
    func updateUser() {
        if let user = user.first {
            user.name = name
            user.age = age
            user.rev_util = rev_util
            user.late_30_59 = late_30_59
            user.debt_ratio = debt_ratio
            user.monthly_inc = monthly_inc
            user.open_credit = open_credit
            user.late_90 = late_90
            user.real_estate = real_estate
            user.late_60_89 = late_60_89
            user.dependents = dependents
            
            do {
                try context.save()
                dismiss()
            } catch {
                print("Failed to update user:", error)
            }
        }
    }
    
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

#Preview {
    UserConfiguration()
}
