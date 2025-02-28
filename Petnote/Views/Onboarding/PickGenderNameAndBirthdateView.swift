//
//  PickGenderNameAndBirthdateView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 27/02/25.
//

import SwiftUI
import SwiftData

enum SelectedSex: String {
    case macho =  "Macho"
    case femea = "Fêmea"
    case none =  "Nenhum"
}

struct PickGenderNameAndBirthdateView: View {
    @AppStorage("isOnboardingCoverShowing") var isOnboardingCoverShowing = true
    @State var selectedSexo: SelectedSex = .none
    @State var name = ""
    @State var date = Date()
    var pet: String
    var breed: String
    @Query var pets: [Pet]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack {
            Text("Informações sobre o pet")
                .font(.title.weight(.semibold))
                .foregroundStyle(.accent)
                .padding(.bottom, 72)
            VStack {
                Text("Selecione o sexo")
                    .font(.custom("SFProRounded-Regular", size: 20))
                    .bold()
                    
                HStack(spacing: 17) {
                    VStack {
                        ZStack {
                            Image(.cachorro)
                                .resizable()
                                .frame(width: 65, height: 65)
                            
                            Circle()
                                .stroke(selectedSexo == .macho ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                .frame(width: 65, height: 65)
                        }
                        Text("Macho")
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedSexo = .macho
                        }
                    }
                    VStack {
                        ZStack {
                            Image(.gato)
                                .resizable()
                                .frame(width: 65, height: 65)
                            
                            Circle()
                                .stroke(selectedSexo == .femea ? Color.blue : Color.clear, style: StrokeStyle(lineWidth: 5))
                                .frame(width: 65, height: 65)
                        }
                        Text("Fêmea")
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedSexo = .femea
                        }
                    }
                }
            }
            .padding(.bottom, 50)
            
            VStack {
                Text("Qual o nome do seu pet?")
                TextField("Digite o nome do pet", text: $name)
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 40)
                
            }
            .padding(.bottom, 40)
            
            VStack {
                Text("Qual a data de nascimento do seu pet?")
                HStack {
                    Text("Data")
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.leading)
                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                        .padding()
                }
                .padding(.vertical, -5)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 40)
                
            }
            .padding(.bottom, 90)
            
            if selectedSexo != .none && name != "" {
                Button {
                    isOnboardingCoverShowing = false
                    print(name, date, selectedSexo.rawValue, pet, breed)
                } label: {
                    Text("Continuar")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.white)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
            } else {
                Text("Continuar")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 300, height: 50)
                    .foregroundStyle(.black)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
        }
    }
}

#Preview {
    PickGenderNameAndBirthdateView(pet: "Cachorro", breed: "Vira-lata")
}
