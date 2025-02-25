//
//  ResumeViewModel.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import Foundation
import SwiftUI
import SwiftData

class ResumeViewModel: ObservableObject {
    @Published var vacinasOrdenadas: [DoseDetalhada] = []
    @Published var isAuthorized: Bool = false
    
    func atualizarVacinas(pets: [Pet]) async {
        var dosesTemp: [DoseDetalhada] = []
        
        for pet in pets {
            for vacina in pet.vacinas {
                for dose in vacina.doses {
                    if let image = UIImage(data: pet.imageURL) {
                        let doseDetalhada = DoseDetalhada(
                            nomeVacina: vacina.name,
                            dose: dose,
                            image: image
                        )
                        dosesTemp.append(doseDetalhada)
                    }
                }
            }
        }

        vacinasOrdenadas = dosesTemp.sorted { $0.dose.data < $1.dose.data }
    }
}
