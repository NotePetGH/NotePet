//
//  FitnessTrackerViewModel.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import Foundation
import SwiftUI

@MainActor
class FitnessTrackerViewModel: ObservableObject {
    private let healthKitManager = HealthKitManager()
    
    @Published var distance: Int = 0
    @Published var time: Int = 0
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    func requestHealthKitAuthorization() async {
        do {
            isAuthorized = try await healthKitManager.requestAuthorization()
            if isAuthorized {
                try await fetchData()
            }
        } catch {
            print("Failed to authorize health kit")
        }
    }
    
    func fetchData() async {
        async let distance = healthKitManager.fetchLastWeekDistance()
        async let time = healthKitManager.fetchLastWeekWalkingTime()
        
        self.distance = await distance
        self.time = await time
    }
}

