//
//  Consulta.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import Foundation
import SwiftData

@Model
class Consulta {
    var title: String
    var data: Date
    var location: String
    var obs: String?
    
    init(title: String, data: Date, location: String, obs: String) {
        self.title = title
        self.data = data
        self.location = location
        self.obs = obs
    }
}
