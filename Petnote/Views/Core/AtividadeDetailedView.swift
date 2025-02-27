//
//  AtividadeDetailedView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI

struct AtividadeDetailedView: View {
    var pet: Pet
    @State var showSheet = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if !pet.caminhadas.isEmpty {
                        Spacer().frame(height: 15)
                        ForEach(pet.caminhadas) { caminhada in
                            CaminhadaItemView(caminhada: caminhada)
                        }
                    } else {
                        Spacer().frame(height: 50)
                        Text("Adicione uma atividade para vê-la!")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    NavigationLink {
                        StartCaminhadaView(pet: pet)
                    } label: {
                        Text("Iniciar passeio")
                            .padding()
                            .background(.thickMaterial)
                            .cornerRadius(30)
                        
                    }
                    .sheet(isPresented: $showSheet) {
                        AddCaminhadaView(pet: pet)
                            .presentationDetents([.height(500)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Atividade")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(Color(red: 0.22, green: 0.31, blue: 0.45), in: Circle())
            })
            
        }
    }
}

#Preview {
    AtividadeDetailedView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: [], caminhadas: []))
}
