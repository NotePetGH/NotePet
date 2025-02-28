//
//  PickBreedView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 27/02/25.
//

import SwiftUI
import SwiftData

enum SelectedDogBreed: String {
    case viralata =  "Vira lata"
    case husky = "Husky"
    case golden = "Golden"
    case shihtzu = "Shih Tzu"
    case pomerania =  "Lulu da Pomerania"
    case pinscher =  "Pinscher"
    case outra =  "Outra"
    case none = "nenhuma"
}

enum SelectedCatBreed: String {
    case srd = "SRD"
    case persa = "Persa"
    case siames = "Siâmes"
    case maine = "Maine"
    case angora = "Angorá"
    case sphynx = "Sphynx"
    case outra = "Outra"
    case none = "nenhuma"
}



struct PickDogBreedView: View {
    var selectedAnimal: SelectedAnimal
    @State var selectedDogBreed: SelectedDogBreed = .none
    var body: some View {
        NavigationStack {
            VStack(spacing: 95) {
                Text("Qual seu bichinho?")
                    .font(.system(size: 28, weight: .medium))
                    .multilineTextAlignment(.center)
                
                VStack {
                    HStack(spacing: 17) {
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .viralata ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("Vira-lata")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .viralata
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .husky ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Husky")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .husky
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .golden ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Golden")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .golden
                        }
                    }
                    HStack(spacing: 17) {
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .shihtzu ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("Shih Tzu")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .shihtzu
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .pomerania ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Pomerânia")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .pomerania
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .pinscher ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Pinscher")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .pinscher
                        }
                    }
                    
                    HStack{
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedDogBreed == .outra ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("Outra")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedDogBreed = .outra
                        }
                    }
                }
                
                
                
                NavigationLink {
                    PickGenderNameAndBirthdateView(pet: selectedAnimal.rawValue, breed: selectedDogBreed.rawValue)
                } label: {
                    Text("Continuar")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.black)
                        .background(Color(red: 1, green: 0.91, blue: 0.49))
                        .overlay {
                            RoundedRectangle(cornerRadius: 50)
                                .inset(by: 0.75)
                                .stroke(Color(red: 1, green: 0.72, blue: 0.29), lineWidth: 1.5)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                
            }
        }
    }
}
struct PickCatBreedView: View {
    var selectedAnimal: SelectedAnimal
    @State var selectedCatBreed: SelectedCatBreed = .none
    var body: some View {
        NavigationStack {
            VStack(spacing: 95) {
                Text("Qual seu bichinho?")
                    .font(.system(size: 28, weight: .medium))
                    .multilineTextAlignment(.center)
                
                VStack {
                    HStack(spacing: 17) {
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .srd ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("SRD")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .srd
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .persa ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Persa")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .persa
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .siames ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Siamês")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .siames
                        }
                    }
                    HStack(spacing: 17) {
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .maine ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("Maine")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .maine
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .angora ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Angora")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .angora
                        }
                        VStack {
                            ZStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .sphynx ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text("Sphynx")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .sphynx
                        }
                    }
                    
                    HStack{
                        VStack {
                            ZStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Circle()
                                    .stroke(selectedCatBreed == .outra ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 80, height: 80)
                                
                            }
                            
                            
                            Text("Outra")
                                .font(.system(size: 20, weight: .medium))
                        }
                        .onTapGesture {
                            selectedCatBreed = .outra
                        }
                    }
                }
                
                
                if selectedCatBreed == .none {
                    Text("Continuar")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.black)
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                } else {
                    NavigationLink {
                        PickGenderNameAndBirthdateView(pet: selectedAnimal.rawValue, breed: selectedCatBreed.rawValue)
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
    PickCatBreedView(selectedAnimal: .gato)
}
