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
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    @Query var pets: [Pet]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 15)
                HStack {
                    Text("Meus bichos")
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                            
                    }
                    .sheet(isPresented: $showSheet) {
                        AddPetView()
                            .presentationDetents([.height(650)])
                            .presentationDragIndicator(.visible)
                        
                    }
                }
                .padding(16)
                
                if !pets.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(pets) { pet in
                                NavigationLink {
                                    PetDetailedView(pet: pet)
                                        .navigationTransition(.zoom(sourceID: "pet", in: namespace))
                                } label: {
                                    PetCardView(imageURL: UIImage(data: pet.imageURL)!, petName: pet.name)
                                        .matchedTransitionSource(id: "pet", in: namespace)
                                }
                                .contextMenu {
                                    Button(role: .destructive){
                                        withAnimation {
                                            modelContext.delete(pet)
                                        }
                                    } label: {
                                        Label("Deletar pet", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                } else {
                    ScrollView {
                        Spacer().frame(height: 100)
                    
                        VStack(spacing: 12) {
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
            .navigationBarHidden(true)
            .navigationTitle("Meus bichos")
        }
    }
}

#Preview {
    MyPetsView()
        .modelContainer(for: Pet.self)
}
