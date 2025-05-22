//
//  User.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/22/25.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: UUID
    var name: String
    var rev_util: Double
    var age: Int
    var late_30_59: Int
    var debt_ratio: Double
    var monthly_inc: Double
    var open_credit: Int
    var late_90: Int
    var real_estate: Int
    var late_60_89: Int
    var dependents: Int
    var delinquency_likelyhood: Double
    
    init(
        id: UUID = .init(),
        name: String,
        rev_util: Double,
        age: Int,
        late_30_59: Int,
        debt_ratio: Double,
        monthly_inc: Double,
        open_credit: Int,
        late_90: Int,
        real_estate: Int,
        late_60_89: Int,
        dependents: Int,
        delinquency_likelyhood: Double
    ) {
        self.id = id
        self.name = name
        self.rev_util = rev_util
        self.age = age
        self.late_30_59 = late_30_59
        self.debt_ratio = debt_ratio
        self.monthly_inc = monthly_inc
        self.open_credit = open_credit
        self.late_90 = late_90
        self.real_estate = real_estate
        self.late_60_89 = late_60_89
        self.dependents = dependents
        self.delinquency_likelyhood = delinquency_likelyhood
    }
}

/*
 User Attributes:
 rev_util: Ratio of revolving credit utilization (balance/credit limit)
 age: Age of the borrower
 late_30_59: Number of times 30-59 days past due (worse than current)
 debt_ratio: Debt to income (or assets) ratio
 monthly_inc: Monthly income of the borrower
 open_credit: Number of open credit lines and loans
 late_90: Number of times 90 days or more late on a payment
 real_estate: Number of real estate loans or credit lines
 late_60_89: Number of times 60-89 days past due (worse than current)
 dependents: Number of dependents
 dlq_2yrs: Target variable indicating if a serious delinquency occurred in the next 2 years (0 = No, 1 = Yes)
 */

// The user's attributes will all be instantiated as defaults, and a prediction won't be allowed
// until the user fills out their details.
