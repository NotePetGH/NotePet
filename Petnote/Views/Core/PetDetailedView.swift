//
//  PetView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct PetDetailedView: View {
    var pet: Pet
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 100) {
                        cover
                        VStack(spacing: 25) {
                            NavigationLink {
                                SaudeDetailView(pet: pet)
                            } label: {
                                HStack {
                                    // Vstack da esquerda
                                    VStack(alignment: .leading) {
                                        //Imagem e título
                                        HStack {
                                            Image(systemName: "heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 22, height: 22)
                                                .foregroundStyle(.red)
                                            Text("Saúde")
                                                .foregroundStyle(.black)
                                                .font(.system(size: 18))
                                        }
                                        
                                        Text("Vacinas, remédios e consultas")
                                            .font(.system(size: 15))
                                            .foregroundStyle(Color(red: 0.47, green: 0.47, blue: 0.47))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                                }
                                .padding(.horizontal, 30)
                            }
                            
                            Divider()
                                .padding(.horizontal, 15)
                            
                            NavigationLink {
                                AtividadeDetailedView(pet: pet)
                            } label: {
                                HStack {
                                    // Vstack da esquerda
                                    VStack(alignment: .leading) {
                                        //Imagem e título
                                        HStack {
                                            Image(systemName: "point.bottomleft.forward.to.arrow.triangle.uturn.scurvepath.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 22, height: 22)
                                                .foregroundStyle(Color(red: 1, green: 0.65, blue: 0.2))
                                            Text("Atividade")
                                                .foregroundStyle(.black)
                                                .font(.system(size: 18))
                                        }
                                        
                                        Text("Registre suas caminhadas")
                                            .font(.system(size: 15))
                                            .foregroundStyle(Color(red: 0.47, green: 0.47, blue: 0.47))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                                }
                                .padding(.horizontal, 30)
                            }
                           
                        }
                        .frame(height: 210)
                        .background(.ultraThinMaterial)
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                    }
                }
                .background(Color(.white))
                .ignoresSafeArea()
                
//                Button {
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.body.weight(.bold))
//                        .foregroundStyle(Color("cinza"))
//                        .padding(8)
//                        .background(.ultraThinMaterial, in: Circle())
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 50)
//                .ignoresSafeArea()
            }
        }
    }
    
    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .foregroundStyle(.black)
        .background(
            Image(uiImage: UIImage(data: pet.imageURL)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .mask (
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 0) {
                Text(pet.name)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(pet.age) anos")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                    .padding(.top,5)
                Text(pet.animal)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                    
                
                
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
                .offset(y: 200)
                .padding(20)
            
            
        )
    }
}


#Preview {
    PetDetailedView(pet: Pet(name: "Lia", age: 4, imageURL: .lia, animal: "Gata", gender: "Fêmea", vacinas: [], consultas: [], remedios: [], caminhadas: []))
}
