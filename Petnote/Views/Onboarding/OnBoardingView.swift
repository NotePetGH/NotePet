//
//  OnBoardingView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftData
import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(spacing: 56) {
                    Text("Gerencie a vida do seu bichinho em um só lugar")
                        .font(.system(size: 28, weight: .medium))
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 36) {
                        HStack {
                            Spacer()
                            Image(.preview3)
                                .resizable()
                                .frame(width: 300, height: 430)
                                .aspectRatio(contentMode: .fit)
                                
                        }
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .inset(by: 0.5)
                                .stroke(Color(red: 1, green: 0.72, blue: 0.29), lineWidth: 1)
                            
                        }
                        NavigationLink {
                            PickPetView()
                        } label: {
                            Text("Vamos lá!")
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
                .padding(.horizontal, 45)
            }
        }
    }
}

#Preview {
    OnBoardingView()
        .modelContainer(for: Pet.self, inMemory: true)
}

