//
//  Vacina.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import Foundation
import SwiftData

@Model
class Vacina {
    var name: String
    var lote: String
    var lab: String
    var doses: [Dose]
    
    init(name: String, lote: String, lab: String, doses: [Dose]) {
        self.name = name
        self.lote = lote
        self.lab = lab
        self.doses = doses
    }
}

@Model
class Dose {
    var data: Date
    var isPending: Bool
    
    init(data: Date, isPending: Bool) {
        self.data = data
        self.isPending = isPending
    }
}
