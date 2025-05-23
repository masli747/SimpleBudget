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
    @State var riskPredictor = DelinquencyPredictor()
    @State private var stackPath = NavigationPath()
    
    var body: some View {
        Group {
            NavigationStack(path: $stackPath) {
                if let user = user.first {
                    VStack {
                        Text("Hello, \(user.name)!")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Based on your provided information,")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if riskPredictor.predictedLabel == 1 {
                            Text("You are AT RISK OF DELINQUENCY!")
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("You're all good!")
                                .foregroundStyle(.green)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                    .task {
                        riskPredictor.predictRisk(
                            user.rev_util,
                            user.age,
                            user.late_30_59,
                            user.debt_ratio,
                            user.monthly_inc,
                            user.open_credit,
                            user.late_90,
                            user.real_estate,
                            user.late_60_89,
                            user.dependents
                        )
                    }
                } else {
                    VStack {
                        Text("Hello, Guest!")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                        
                        Text("You need to create an account, and enter some details about yourself, before we can calculate your risk of delinquency.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                        
                        NavigationLink {
                            UserConfiguration()
                        } label: {
                            ListCell(message: "Register as a New User")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        
                        Spacer()
                    }
                }
            }
            .onChange(of: selectedTab) {
                Task {
                    await refresh?()
                }
            }
        }
    }
}


#Preview {
    DelinquencyView(selectedTab: .constant(.delinquency))
}
