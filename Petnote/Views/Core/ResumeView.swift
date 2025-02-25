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
    @StateObject private var resumeViewModel = ResumeViewModel()
    @Query var pets: [Pet]
    @State private var vacinasOrdenadas: [DoseDetalhada] = []
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer().frame(height: 8)
                        // Essa semana
                        AtividadeView(viewModel: viewModel)
                        
                        VStack(spacing: 10) {
                            //Header
                            HStack {
                                Image(systemName: "pill")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Vacinas")
                                    .font(.system(size: 20, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .regular))
                            }
                            .foregroundStyle(.black)
                            .padding([.top, .horizontal], 12)
                            
                            //Body
                            
                            if !vacinasOrdenadas.isEmpty{
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Próxima")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.accent.opacity(0.6))
                                        Text(vacinasOrdenadas.first!.nomeVacina)
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundStyle(.accent)
                                        HStack(spacing: 6) {
                                            Divider().frame(height: 24)
                                            Text("")
                                                .font(.system(size: 14))
                                                .foregroundStyle(.secondary)
                                        }
                                        .padding(.bottom, 5)
                                        
                                        Text("\(vacinasOrdenadas.first!.dose.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                            .font(.system(size: 20, weight: .regular))
                                            .foregroundStyle(.black)
                                    }
                                    Spacer()
                                    
                                    Image(uiImage: UIImage(data: vacinasOrdenadas.first!.image)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50)
                                        .clipShape(Circle())
                                }
                                .padding(.horizontal, 17)
                                .padding(.bottom, 12)
                            } else {
                                Text("Adicionar")
                                    .padding()
                            }
                        }
                        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 4)
                        .padding(.horizontal)
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
                                                Text("Parece que você não adicionou um remédio!")
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                            } else {
                                                ForEach(vacinasOrdenadas) { vacina in
                                                    DoseDetalhadaRowView(dose: vacina)
                                                }
                                            }
                                        }
                                        .padding(.vertical, 9)
                                    }
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
                                        
                                        Text("Parece que você não adicionou uma próxima vacina!")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
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
                                        HStack {
                                            Text("Consultas")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundStyle(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                        
                                        Divider()
                                        Text("Parece que você não adicionou uma próxima vacina!")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                        .padding(.top, 9)
                                        
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: 170, minHeight: 100, maxHeight: 300)
                                    .modifier(ItemModifier())
                                    .padding(.trailing)
                                }
                                Rectangle().fill(.clear)
                            }
                        }
                    }
                }
                .navigationTitle("Resumo")
            
        }
        .onAppear {
            if isAuthorized {
                Task {
                    await viewModel.fetchData()
                    await resumeViewModel.atualizarVacinas(pets: pets)
                    self.vacinasOrdenadas = resumeViewModel.vacinasOrdenadas
                }
            }
        }
    }
    
}

#Preview {
    ResumeView()
        .modelContainer(for: Pet.self)
}





struct AtividadeView: View {
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @ObservedObject var viewModel: FitnessTrackerViewModel
    var body: some View {
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
                
                HStack(alignment: .top,spacing: 47) {
                    ProgressCircle(progress: viewModel.distance)
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
    }
}

struct ProgressCircle: View {
    var progress: Int
    
    func calcCircleSize(distance: Int) -> Double {
        let size: Double = Double(distance) / 100000 + 0.01
        return size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.orange.opacity(0.1), style: StrokeStyle(lineWidth: 8))
                .frame(width: 75)

            Circle()
                .trim(from: 0, to: calcCircleSize(distance: progress))
                .stroke(LinearGradient(colors: [Color.orange, Color.red], startPoint: .bottomTrailing, endPoint: .topLeading), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 75)
                .rotationEffect(.init(degrees: -90))

            Image(systemName: "flame.fill")
                .resizable()
                .frame(width: 30, height: 35)
                .foregroundStyle(LinearGradient(colors: [Color.orange, Color.red], startPoint: .topTrailing, endPoint: .bottomLeading))
        }
    }
}
