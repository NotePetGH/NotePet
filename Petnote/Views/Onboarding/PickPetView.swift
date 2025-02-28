//
//  PickPetView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//
import SwiftUI
import SwiftData

enum SelectedAnimal: String {
    case cachorro = "Cachorro"
    case gato =  "Gato"
    case none =  "Nenhuma"
}

struct PickPetView: View {
    @State var selectedAnimal: SelectedAnimal = .none
    var body: some View {
        NavigationStack {
            VStack(spacing: 180) {
                Text("Qual seu bichinho?")
                    .font(.system(size: 28, weight: .medium))
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 17) {
                    VStack {
                        ZStack {
                            Image(.cachorro)
                                .resizable()
                                .frame(width: 125, height: 125)
                            Circle()
                                .stroke(selectedAnimal == .cachorro ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                .frame(width: 125, height: 125)
                            
                        }
                        
                        
                        Text("Cachorro")
                            .font(.system(size: 20, weight: .medium))
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedAnimal = .cachorro
                        }
                    }
                    VStack {
                        ZStack {
                            Image(.gato)
                                .resizable()
                                .frame(width: 125, height: 125)
                            Circle()
                                .stroke(selectedAnimal == .gato ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                .frame(width: 125, height: 125)
                        }
                        
                        Text("Gato")
                            .font(.system(size: 20, weight: .medium))
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedAnimal = .gato
                        }
                    }
                }
                
                if selectedAnimal == .none {
                    Text("Continuar")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.black)
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                } else {
                    NavigationLink {
                        if selectedAnimal == .gato {
                            PickCatBreedView(selectedAnimal: selectedAnimal)
                        } else if selectedAnimal == .cachorro {
                            PickDogBreedView(selectedAnimal: selectedAnimal)
                        }
                        
                    } label: {
                        Text("Continuar")
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: 300, height: 50)
                            .foregroundStyle(.white)
                            .background(.accent)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                
            }
        }
        
        
    }
}

#Preview {
    PickPetView()
        .modelContainer(for: Pet.self, inMemory: true)
}

struct ExtractedView: View {
    var body: some View {
        VStack {
            Image(systemName: "circle")
                .resizable()
                .frame(width: 100, height: 100)
                .fontWeight(.ultraLight)
            Text("Pet")
                .font(.system(size: 22))
        }
    }
}
