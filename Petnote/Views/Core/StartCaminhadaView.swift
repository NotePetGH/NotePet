//
//  StartCaminhadaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI
import MapKit
import SwiftData

struct StartCaminhadaView: View {
    @State private var petsSelecionados: Set<Pet> = []
    @StateObject var caminhadaManager = CaminhadaManager()
    @Environment(\.modelContext) var modelContext
    @Query var pets: [Pet]

    var pet: Pet
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Selecionar pets").fontWeight(.semibold)
                    VStack(spacing: 15) {
                        ForEach(pets, id: \.self) { pet in
                            HStack {
                                Image(uiImage: UIImage(data: pet.imageURL)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Text(pet.name)
                                Spacer()
                                Image(systemName: petsSelecionados.contains(pet) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.blue)
                                
                            }
                            .onTapGesture {
                                if petsSelecionados.contains(pet) {
                                    petsSelecionados.remove(pet) // Desmarca se já estiver selecionado
                                } else {
                                    petsSelecionados.insert(pet) // Marca como selecionado
                                }
                            }
                        }
                    }
                    .padding(12)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                    .cornerRadius(15)
                }
                
                Map(position: $caminhadaManager.mapPosition) {
                    UserAnnotation()
                    
                    MapPolyline(coordinates: caminhadaManager.routeCoordinates)
                        .stroke(.blue, lineWidth: 5)
                }
                .mapControls {
                    MapUserLocationButton() // Botão para centralizar a localização
                }
                .frame(height: 300)
                .cornerRadius(12)
                
                Text("Distância: \(Int(caminhadaManager.distance)) metros")
                    .font(.title)
                
                Text("Tempo: \(formatarTempo(caminhadaManager.elapsedTime))")
                    .font(.title)
                
                if caminhadaManager.isTracking {
                    Button("Parar Caminhada") {
                        caminhadaManager.stopTracking()
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Finalizar Caminhada") {
                        caminhadaManager.finalizarCaminhada(para: Array(petsSelecionados), modelContext: modelContext)
                    }
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                } else {
                    Button("Iniciar Caminhada") {
                        caminhadaManager.requestPermission()
                        caminhadaManager.startTracking()
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }

    func formatarTempo(_ time: TimeInterval) -> String {
        let minutos = Int(time) / 60
        let segundos = Int(time) % 60
        return String(format: "%02d:%02d", minutos, segundos)
    }
}

#Preview {
    StartCaminhadaView(pet: Pet(name: "Mite", age: 2, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: [], caminhadas: []))
}
