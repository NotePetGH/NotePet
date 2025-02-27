//
//  Consulta.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import Foundation
import SwiftData
import PhotosUI

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

class ConsultaDetalhada: Identifiable {
    var id = UUID()
    var title: String
    var data: Date
    var location: String
    var obs: String?
    var image: Data
    
    init(id: UUID = UUID(), title: String, data: Date, location: String, obs: String? = nil, image: UIImage) {
        self.id = id
        self.title = title
        self.data = data
        self.location = location
        self.obs = obs
        self.image = image.pngData()!
    }
    
}
