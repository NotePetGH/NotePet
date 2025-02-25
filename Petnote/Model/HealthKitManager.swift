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
            HKObjectType.workoutType(),
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
    func fetchLastWeekWalkingTime() async -> Int {
            let workoutType = HKObjectType.workoutType()

            let now = Date()
            let startDate = Calendar.current.date(byAdding: .day, value: -7, to: now)!
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
            
            // Filtrar apenas treinos de caminhada
            let walkingPredicate = HKQuery.predicateForWorkouts(with: .walking)
            let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, walkingPredicate])

            return await withCheckedContinuation { continuation in
                let query = HKSampleQuery(sampleType: workoutType, predicate: combinedPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
                    if let error = error {
                        print("Erro ao buscar treinos: \(error.localizedDescription)")
                        continuation.resume(returning: 0)
                        return
                    }
                    
                    guard let workouts = samples as? [HKWorkout] else {
                        print("Nenhum treino encontrado")
                        continuation.resume(returning: 0)
                        return
                    }

                    print("Treinos encontrados: \(workouts.count)")
                    for workout in workouts {
                        print("Treino: \(workout.workoutActivityType) - \(workout.duration / 60) minutos")
                    }

                    let totalWalkingTime = workouts.reduce(0) { sum, workout in
                        sum + Int(workout.duration / 60)// Converter segundos para minutos
                    }
                    
                    continuation.resume(returning: totalWalkingTime)
                }
                healthStore.execute(query)
            }
        }
    
}

