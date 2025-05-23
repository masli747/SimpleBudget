//
//  Expense.swift
//  SimpleBudget
//
//  Created by Art Song on 5/22/25.
//


import Foundation
import SwiftData

@Model
class Expense {
    @Attribute(.unique) var id: UUID
    var date: Date
    var amount: Double
    var category: String
    var note: String?

    init(
        id: UUID = .init(),
        date: Date = .init(),
        amount: Double,
        category: String,
        note: String? = nil
    ) {
        self.id = id
        self.date = date
        self.amount = amount
        self.category = category
        self.note = note
    }
}
