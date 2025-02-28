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
    @State var showSheet = true
    @Query var pets: [Pet]
    var pet: Pet
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ScrollView {
                    Map(position: $caminhadaManager.mapPosition) {
                        UserAnnotation()
                        
                        MapPolyline(coordinates: caminhadaManager.routeCoordinates)
                            .stroke(.blue, lineWidth: 5)
                    }
                    .mapControls {
                        MapUserLocationButton() // Botão para centralizar a localização
                    }
                    .frame(height: 500)
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .sheet(isPresented: $showSheet) {
                    VStack {
                        if caminhadaManager.isTracking {
                            isTrackingView(petsSelecionados: petsSelecionados)
                        } else {
                            isNotTrackingView(pets: pets, petsSelecionados: $petsSelecionados)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(420)))
                    .presentationDetents([.height(420)])
                    .interactiveDismissDisabled()
                }
            }
            .ignoresSafeArea()
        }
        .environmentObject(caminhadaManager)
    }
    
    
    struct isTrackingView: View {
        @EnvironmentObject var caminhadaManager: CaminhadaManager
        @Environment(\.modelContext) var modelContext
        var petsSelecionados: Set<Pet>
        var body: some View {
            HStack {
                Text("Começar passeio")
                    .font(.title.weight(.semibold))
                    .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Selecionar pets").fontWeight(.semibold)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Text("Pets inclusos")
                    HStack {
                        ForEach(Array(petsSelecionados)) { pet in
                            Image(uiImage: UIImage(data: pet.imageURL)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(12)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(15)
            }
            HStack {
                Spacer()
                VStack {
                    Text("Distância \(Int(caminhadaManager.distance))m")
                    Text("Tempo \(formatarTempo(caminhadaManager.elapsedTime))")
                }
                Spacer()
            }
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                caminhadaManager.finalizarCaminhada(para: Array(petsSelecionados), modelContext: modelContext)
            } label: {
                Text("Encerrar passeio")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.top)
            }
        }
        func formatarTempo(_ time: TimeInterval) -> String {
            let minutos = Int(time) / 60
            let segundos = Int(time) % 60
            return String(format: "%02d:%02d", minutos, segundos)
        }
    }
    
    struct isNotTrackingView: View {
        @EnvironmentObject var caminhadaManager: CaminhadaManager
        var pets: [Pet]
        @Binding var petsSelecionados: Set<Pet>
        var body: some View {
            HStack {
                Text("Começar passeio")
                    .font(.title.weight(.semibold))
                    .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Selecionar pets").fontWeight(.semibold)
                    Spacer()
                }
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
            HStack {
                Spacer()
                VStack {
                    Text("Distância \(Int(caminhadaManager.distance))m")
                    Text("Tempo \(formatarTempo(caminhadaManager.elapsedTime))")
                }
                Spacer()
            }
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            Button {
                caminhadaManager.requestPermission()
                caminhadaManager.startTracking()
            } label: {
                Text("Continuar")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.white)
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.top)
            }
        }
        func formatarTempo(_ time: TimeInterval) -> String {
            let minutos = Int(time) / 60
            let segundos = Int(time) % 60
            return String(format: "%02d:%02d", minutos, segundos)
        }
    }
}
