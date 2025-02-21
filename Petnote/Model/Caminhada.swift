//
//  Caminhada.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import Foundation
import SwiftData

@Model
class Caminhada {
    var distance: Double
    var time: Double
    
    init(distance: Double, time: Double) {
        self.distance = distance
        self.time = time
    }
}
