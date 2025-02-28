//
//  MyPetsView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI
import SwiftData

struct MyPetsView: View {
    @Namespace var namespace
    @State var showSheet = false
    @Environment(\.modelContext) var modelContext
    @Query var pets: [Pet]
    var body: some View {
        NavigationStack {
            VStack {
                if !pets.isEmpty {
                    ScrollView(.horizontal) {
                        Spacer().frame(height: 20)
                        HStack(spacing: 15) {
                            Spacer()
                            ForEach(pets) { pet in
                                NavigationLink {
                                    PetDetailedView(pet: pet)
                                        .navigationTransition(.zoom(sourceID: "pet\(pet.id)", in: namespace))
                                } label: {
                                    PetCardView(imageURL: UIImage(data: pet.imageURL)!, petName: pet.name)
                                        .matchedTransitionSource(id: "pet\(pet.id)", in: namespace)
                                        
                                        
                                }
                                .contextMenu {
                                    Button(role: .destructive){
                                        withAnimation() {
                                            deletarPet(pet)
                                        }
                                    } label: {
                                        Label("Deletar pet", systemImage: "trash")
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .scrollTargetLayout()
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                    
                } else {
                    ScrollView {
                        Spacer().frame(height: 50)
                        
                        VStack(spacing: 15) {
                            Text("🐶")
                                .font(.largeTitle)
                            Text("Parece que você não adicionou um pet ainda. Clique no + para adicionar!")
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.gray)
                                .font(.body)
                            
                        }
                    }
                        
                }
                
                
                Spacer()
                
            }
            .sheet(isPresented: $showSheet) {
                AddPetView()
                    .presentationDetents([.height(600)])
                    .presentationDragIndicator(.visible)
                
            }
            .navigationBarItems(trailing: Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(Color(red: 0.22, green: 0.31, blue: 0.45), in: Circle())
            })
            .navigationTitle("Meus bichos")
        }
    }
    private func deletarPet(_ pet: Pet) {
            modelContext.delete(pet) // Remove do SwiftData
            try? modelContext.save() // Salva as mudanças
        }
}

#Preview {
    MyPetsView()
        .modelContainer(for: Pet.self)
}
