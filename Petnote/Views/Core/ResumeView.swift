//
//  ResumeView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 13/02/25.
//

import SwiftUI
import SwiftData

struct ResumeView: View {
    @Query var pets: [Pet]
    
    var vacinasComDosesOrdenadas: [DoseDetalhada] {
        pets
            .flatMap { pet in
                pet.vacinas.flatMap { vacina in
                    vacina.doses.map { dose in
                        DoseDetalhada(nomeVacina: vacina.name, dose: dose, image: UIImage(data: pet.imageURL)!)
                    }
                }
            }
            .sorted { $0.dose.data < $1.dose.data }
        }

    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 15)
                HStack {
                    Text("Acompanhamento")
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Circle()
                        .frame(width: 50)
                    
                }
                .padding(.horizontal)
                ScrollView {
                    VStack(spacing: 10) {
                        // Essa semana
                        NavigationLink {
                            
                        } label: {
                            VStack {
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Essa semana")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.black)
                                    
                                    Text("16/02 - 23/02")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.gray)
                                }
                                
                                Divider()
                                
                                HStack(spacing: 47) {
                                    ZStack {
                                        Circle()
                                            .stroke(Color.clear.opacity(0.3), style: StrokeStyle(lineWidth: 8))
                                            .frame(width: 75)
                                        
                                        Circle()
                                            .trim(from: 0, to: 0.9)
                                            .stroke(LinearGradient(colors: [Color(red: 1, green: 0.65, blue: 0.05), Color(red: 0.82, green: 0, blue: 0)], startPoint: .bottomTrailing, endPoint: .topLeading), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                            .frame(width: 75)
                                            .rotationEffect(.init(degrees: -90))
                                        
                                        Image(systemName: "flame.fill")
                                            .resizable()
                                            .frame(width: 30, height: 35)
                                            .foregroundStyle(LinearGradient(colors: [Color(red: 1, green: 0.65, blue: 0.05), Color(red: 0.82, green: 0, blue: 0)], startPoint: .topTrailing, endPoint: .bottomLeading))
                                    }
                                    
                                    VStack(spacing: 11) {
                                        Text("3.250m percorridos")
                                        Text("1,5h de caminhada")
                                    }
                                    .foregroundStyle(.black)
                                }
                                .padding(.vertical, 25)
                            }
                            .modifier(ItemModifier())
                            .padding(.horizontal)
                        }
                        
                        //Separador
                        HStack(alignment: .top, spacing: 10) {
                            // Pilha da esquerda
                            VStack {
                                NavigationLink {
                                    
                                } label: {
                                    VStack {
                                        HStack {
                                            Text("Vacinas")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundStyle(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                        
                                        Divider()
                                        
                                        VStack(spacing: 12) {
                                            ForEach(vacinasComDosesOrdenadas) { vacina in
                                                DoseDetalhadaRowView(dose: vacina)
                                            }
                                        }
                                        .padding(.top, 9)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 200, maxHeight: 300)
                                    .modifier(ItemModifier())
                                    .padding(.leading)
                                }
                                NavigationLink {
                                    
                                } label: {
                                    VStack {
                                        HStack {
                                            Text("Remédios")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundStyle(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                        
                                        Divider()
                                        
                                        VStack(spacing: 12) {                                        }
                                        .padding(.top, 9)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 170, maxHeight: 170)
                                    .modifier(ItemModifier())
                                    .padding(.leading)
                                }
                                
                            }
                            
                            // Pilha da direita
                            VStack {
                                // Consultas
                                NavigationLink {
                                    
                                } label: {
                                    VStack {
                                        // Cabeçalho
                                        HStack {
                                            Text("Consultas")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundStyle(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                        
                                        Divider()
                                        
                                        ConsultaRowItemView()
                                        ConsultaRowItemView()
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 300, maxHeight: 300)
                                    .modifier(ItemModifier())
                                    .padding(.trailing)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ResumeView()
        .modelContainer(for: Pet.self)
}

struct ItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(11)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color(red: 0.01, green: 0.01, blue: 0.01).opacity(0.07), radius: 2, x: 0, y: 2)
    }
}

class DoseDetalhada: Identifiable {
    var id = UUID()
    var nomeVacina: String
    var dose: Dose
    var image: Data
    
    init(id: UUID = UUID(), nomeVacina: String, dose: Dose, image: UIImage) {
        self.id = id
        self.nomeVacina = nomeVacina
        self.dose = dose
        self.image = image.pngData()!
    }
    
}
