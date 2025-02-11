//
//  Remedio.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 11/02/25.
//


import Foundation
import SwiftData

@Model
class Remedio {
    var name: String
    var unity: String
    var dose: Int
    var frequency: DateInterval
    var startDate: Date
    var interval: DateInterval
    var intervalBetweenDays: DateInterval
    
    init(name: String, unity: String, dose: Int, frequency: DateInterval, startDate: Date, interval: DateInterval, intervalBetweenDays: DateInterval) {
        self.name = name
        self.unity = unity
        self.dose = dose
        self.frequency = frequency
        self.startDate = startDate
        self.interval = interval
        self.intervalBetweenDays = intervalBetweenDays
    }
}
