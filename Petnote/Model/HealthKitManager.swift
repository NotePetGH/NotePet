//
//  HealthKitManager.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization() async throws -> Bool {
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            healthStore.requestAuthorization(toShare: nil, read: readTypes) {
                succes, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: succes)
                }
            }
        }
    }
    
    func fetchLastWeekDistance() async -> Int {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        let now = Date()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
                _,result,_ in
                
                guard let result = result, let sum = result.sumQuantity() else {
                    continuation.resume(returning: 0)
                    return
                }
                
                let distance = Int(sum.doubleValue(for: HKUnit.meter()))
                continuation.resume(returning: distance)
            }
            healthStore.execute(query)
        }
    }
    func fetchLastWeekTime() async -> Int {
        let timeType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
        
        let now = Date()
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        
        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: timeType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
                _,result,_ in
                
                guard let result = result, let sum = result.sumQuantity() else {
                    continuation.resume(returning: 0)
                    return
                }
                
                let time = Int(sum.doubleValue(for: HKUnit.minute()))
                continuation.resume(returning: time)
            }
            healthStore.execute(query)
        }
    }
    
}

