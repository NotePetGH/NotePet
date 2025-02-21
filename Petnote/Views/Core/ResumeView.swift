//
//  ResumeView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 13/02/25.
//

import SwiftUI
import SwiftData

struct ResumeView: View {
    @StateObject private var viewModel = FitnessTrackerViewModel()
    @Query var pets: [Pet]
    @State private var vacinasOrdenadas: [DoseDetalhada] = []
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    func calcCircleSize(distance: Int) -> Double {
        let distanceDouble = Double(distance)
        let size: Double = distanceDouble/12000 + 0.01
        print(size)
        return size
        
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
                        .frame(width: 45)
                    
                }
                .padding(.horizontal)
                ScrollView {
                    VStack(spacing: 10) {
                        // Essa semana
                        NavigationLink {
                            
                        } label: {
                            VStack {
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Atividade")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.black)
                                    
                                    Text("Essa semana")
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
                                            .stroke(Color.orange.opacity(0.1), style: StrokeStyle(lineWidth: 8))
                                            .frame(width: 75)
                                        
                                        Circle()
                                            .trim(from: 0, to: calcCircleSize(distance: viewModel.distance))
                                            .stroke(LinearGradient(colors: [Color(red: 1, green: 0.65, blue: 0.05), Color(red: 0.82, green: 0, blue: 0)], startPoint: .bottomTrailing, endPoint: .topLeading), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                            .frame(width: 75)
                                            .rotationEffect(.init(degrees: -90))
                                        
                                        Image(systemName: "flame.fill")
                                            .resizable()
                                            .frame(width: 30, height: 35)
                                            .foregroundStyle(LinearGradient(colors: [Color(red: 1, green: 0.65, blue: 0.05), Color(red: 0.82, green: 0, blue: 0)], startPoint: .topTrailing, endPoint: .bottomLeading))
                                    }
                                    if isAuthorized {
                                        VStack(spacing: 11) {
                                            Text("\(viewModel.distance)m percorridos")
                                            Text("\(viewModel.time)min de caminhada")
                                        }
                                        .foregroundStyle(.black)
                                        
                                    } else {
                                        VStack {
                                            Text("Health Kit access required!")
                                                .font(.headline)
                                                .foregroundStyle(.red)
                                            
                                            Button {
                                                Task {
                                                    await viewModel.requestHealthKitAuthorization()
                                                }
                                            } label: {
                                                Text("Authorize HealthKit")
                                            }
                                            .buttonStyle(.borderedProminent)
                                            
                                        }
                                    }
                                    
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
                                            if vacinasOrdenadas.isEmpty {
                                                Text("Parece que você não adicionou uma próxima vacina!")
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                            } else {
                                                ForEach(vacinasOrdenadas) { vacina in
                                                    DoseDetalhadaRowView(dose: vacina)
                                                }
                                            }
                                        }
                                        .padding(.top, 9)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 110, maxHeight: 300)
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
                                        
                                        VStack(spacing: 12) {
                                            if vacinasOrdenadas.isEmpty {
                                                Text("Parece que você não adicionou um remédio!")
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                            } else {
                                                ForEach(vacinasOrdenadas) { vacina in
                                                    DoseDetalhadaRowView(dose: vacina)
                                                }
                                            }
                                        }
                                        .padding(.top, 9)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 100, maxHeight: 300)
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
                                        
                                        VStack(spacing: 12) {
                                            if vacinasOrdenadas.isEmpty {
                                                Text("Parece que você não adicionou uma próxima consulta!")
                                                    .multilineTextAlignment(.center)
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                            } else {
                                                ForEach(vacinasOrdenadas) { vacina in
                                                    DoseDetalhadaRowView(dose: vacina)
                                                }
                                            }
                                        }
                                        .padding(.top, 9)
                                        
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 110, maxHeight: 300)
                                    .modifier(ItemModifier())
                                    .padding(.trailing)
                                }
                                Rectangle().fill(.clear)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if isAuthorized {
                Task {
                    await viewModel.fetchData()
                }
            }
            atualizarVacinas()
        }
    }
    private func atualizarVacinas() {
        vacinasOrdenadas = pets
            .flatMap { pet in
                pet.vacinas.flatMap { vacina in
                    vacina.doses.map { dose in
                        DoseDetalhada(nomeVacina: vacina.name, dose: dose, image: UIImage(data: pet.imageURL)!)
                    }
                }
            }
            .sorted { $0.dose.data < $1.dose.data }
    }
    
}

#Preview {
    ResumeView()
        .modelContainer(for: Pet.self)
}




