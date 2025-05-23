//
//  DelinquencyPredictor.swift
//  SimpleBudget
//
//  Created by Mason Li on 5/23/25.
//

import Foundation
import CoreML

@Observable class DelinquencyPredictor {
    var predictedLabel: Int = 0
    var confidence: Double = 0.0
    var model: CreditRiskClassifier?
    
    init() {
        do {
//            let config = MLModelConfiguration()
            self.model = try CreditRiskClassifier(configuration: .init())
        } catch {
            print("Error Loading Model!")
        }
    }
    
    func predictRisk(
        _ revUtil: Double,
        _ age: Int,
        _ late_30_59: Int,
        _ debt_ratio: Double,
        _ monthly_inc: Double,
        _ open_credit: Int,
        _ late_90: Int,
        _ real_estate: Int,
        _ late_60_89: Int,
        _ dependents: Int
    ) {
        // Unwrap the loaded model
        guard let model = model else {
            print("Model is not loaded")
            return
        }
        
        do {
            // Make the prediction
            let output = try model.prediction(
                rev_util: revUtil,
                age: Double(age),
                late_30_59: Double(late_30_59),
                debt_ratio: debt_ratio,
                monthly_inc: monthly_inc,
                open_credit: Double(open_credit),
                late_90: Double(late_90),
                real_estate: Double(real_estate),
                late_60_89: Double(late_60_89),
                dependents: Double(dependents)
            )
            
            // Determine predicted label and its confidence
            let label = output.dlq_2yrs // Get class label
            self.predictedLabel = Int(label)
            if let conf = output.dlq_2yrsProbability[label] {   // Map it to the confidence dictionary
                self.confidence = conf
            } else {
                print("No probability entry for label \(label)")
            }
        } catch {
            print("Error Predicting Risk! \(error)")
        }
        
    }
}
