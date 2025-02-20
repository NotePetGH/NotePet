//
//  PickPetView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//
import SwiftUI
import SwiftData

struct PickPetView: View {
    @State private var showTabView = false
    var body: some View {
        if showTabView {
            MainTabView(show: $showTabView)
                .navigationBarBackButtonHidden()
        } else {
            NavigationStack {
                VStack(spacing: 180) {
                        Text("Qual seu bichinho?")
                            .font(.system(size: 28, weight: .medium))
                            .multilineTextAlignment(.center)
                        
                        HStack(spacing: 17) {
                            VStack {
                                Image(.cachorro)
                                    .resizable()
                                    .frame(width: 125, height: 125)
                                
                                Text("Cachorro")
                                    .font(.system(size: 20, weight: .medium))
                            }
                            VStack {
                                Image(.gato)
                                    .resizable()
                                    .frame(width: 125, height: 125)
                                
                                Text("Gato")
                                    .font(.system(size: 20, weight: .medium))
                            }
                        }
                    
                    Button {
                        withAnimation {
                            showTabView.toggle()
                        }
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
