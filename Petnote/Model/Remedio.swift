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
    var dose: String
    var startDate: Date
    var endDate: Date
    var quantityPerDay: String
    
    init(name: String, dose: String, startDate: Date, endDate: Date, quantityPerDay: String) {
        self.name = name
        self.dose = dose
        self.startDate = startDate
        self.endDate = endDate
        self.quantityPerDay = quantityPerDay
    }
}
