//
//  DoseDetalhada.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//
import Foundation
import PhotosUI

class DoseDetalhada: Identifiable {
    var id = UUID()
    var nomeVacina: String
    var dose: Dose
    var image: Data
    var lab: String
    var lote: String
    
    init(id: UUID = UUID(), nomeVacina: String, dose: Dose, image: UIImage, lab: String, lote: String) {
        self.id = id
        self.nomeVacina = nomeVacina
        self.dose = dose
        self.image = image.pngData()!
        self.lab = lab
        self.lote = lote
    }
    
}

