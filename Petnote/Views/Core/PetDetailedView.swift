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
                    VStack(spacing: 80) {
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
                                            Image(systemName: "heart.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
                                                .foregroundStyle(Color(red: 0.15, green: 0.79, blue: 0.59))
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
                                .padding(.horizontal, 37)
                            }
                            
                            Divider()
                                .padding(.horizontal, 15)
                            
                            NavigationLink {
                                Text("Oi")
                            } label: {
                                HStack {
                                    // Vstack da esquerda
                                    VStack(alignment: .leading) {
                                        //Imagem e título
                                        HStack {
                                            Image(systemName: "point.bottomleft.forward.to.arrow.triangle.uturn.scurvepath.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
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
                                .padding(.horizontal, 37)
                            }
                           
                        }
                        .frame(height: 220)
                        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                    }
                }
                .background(Color(.white))
                .ignoresSafeArea()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.bold))
                        .foregroundStyle(Color("cinza"))
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
                .padding(.vertical, 50)
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
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
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 12) {
                
                Text("\(pet.animal) - \(pet.age) anos".uppercased())
                    .font(.footnote.weight(.semibold))
                Text(pet.name)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                )
                .offset(y: 200)
                .padding(20)
            
            
        )
    }
}


#Preview {
    PetDetailedView(pet: Pet(name: "Lia", age: 4, imageURL: .lia, animal: "Gata", gender: "Fêmea", vacinas: [], consultas: [], remedios: []))
}
