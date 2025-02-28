//
//  Pet.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import Foundation
import PhotosUI
import SwiftData

@Model
class Pet: Identifiable {
    var id = UUID()
    var name: String
    var age: Int
    var imageURL: Data
    var animal: String
    var gender: String
    var vacinas: [Vacina]
    var consultas: [Consulta]
    var remedios: [Remedio]
    var caminhadas: [Caminhada]
    var distanciaHoje: Int = 0
    var tempoHoje: TimeInterval = 0
    
    init(name: String, age: Int, imageURL: UIImage, animal: String, gender: String, vacinas: [Vacina], consultas: [Consulta], remedios: [Remedio], caminhadas: [Caminhada]) {
        self.name = name
        self.age = age
        self.imageURL = imageURL.pngData()!
        self.animal = animal
        self.gender = gender
        self.vacinas = vacinas
        self.consultas = consultas
        self.remedios = remedios
        self.caminhadas = caminhadas
    }
}
