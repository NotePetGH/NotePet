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
    @State private var consultasOrdenadas: [ConsultaDetalhada] = []
    @State private var remediosOrdenados: [RemedioDetalhado] = []
    @State private var caminhadasNaSemana = 0
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    Spacer().frame(height: 3)
                    // Essa semana
                    AtividadeView(viewModel: resumeViewModel)
                    VacinasView(vacinasOrdenadas: vacinasOrdenadas)
                    ConsultasView(consultasOrdenadas: consultasOrdenadas)
                    RemediosView(remediosOrdenados: remediosOrdenados)
                    
                }
            }
            .navigationTitle("Resumo")
        }
        .onAppear {
            Task {
                await resumeViewModel.atualizarVacinas(pets: pets)
                self.vacinasOrdenadas = resumeViewModel.vacinasOrdenadas
                await resumeViewModel.atualizarConsultas(pets: pets)
                self.consultasOrdenadas = resumeViewModel.consultasOrdenadas
                await resumeViewModel.atualizarRemedios(pets: pets)
                self.remediosOrdenados = resumeViewModel.remediosOrdenados
                await resumeViewModel.atualizarDistancia(pets: pets)
                await resumeViewModel.atualizarTempo(pets: pets)
                await resumeViewModel.caminhadasNaSemana(pets: pets)
                self.caminhadasNaSemana = resumeViewModel.caminhadasNaSemana
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
    @StateObject var viewModel = ResumeViewModel()
    var body: some View {
        NavigationLink {
            ResumeAtividadeDetailView()
        } label: {
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "flame")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                    Text("Atividade")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                    
                    Text("Essa semana")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                
                HStack(alignment: .top,spacing: 47) {
                    ProgressCircle(progress: Int(viewModel.caminhadasNaSemana))
                    VStack(alignment: .trailing, spacing: 11) {
                            Text("\(Int(viewModel.distanciaTotal))m percorridos")
                            Text("\(Int(viewModel.tempoTotal) / 60)min de caminhada")
                        }
                        .foregroundStyle(.black)
                        
//                    } else {
//                        VStack {
//                            Text("Acesso ao HealKit necessário!")
//                                .font(.headline)
//                                .foregroundStyle(.red)
//                            
//                            Button {
//                                Task {
//                                    await viewModel.requestHealthKitAuthorization()
//                                }
//                            } label: {
//                                Text("Autorizar")
//                            }
//                            .buttonStyle(.borderedProminent)
//                            
//                        }
//                    }
                    
                }
                .padding(.vertical, 15)
            }
            .modifier(ItemModifier())
            .padding(.horizontal)
        }
    }
}

struct ProgressCircle: View {
    var progress: Int
    
    func calcCircleSize(distance: Int) -> Double {
        let size: Double = Double(distance) / 7 + 0.01
        return size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 0.22, green: 0.69, blue: 0.89).opacity(0.1), style: StrokeStyle(lineWidth: 8))
                .frame(width: 75)
            
            Circle()
                .trim(from: 0, to: calcCircleSize(distance: progress))
                .stroke(LinearGradient(colors: [Color(red: 0.73, green: 0.91, blue: 1), Color(red: 0.34, green: 0.66, blue: 0.93)], startPoint: .bottomTrailing, endPoint: .topLeading), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 75)
                .rotationEffect(.init(degrees: -90))
            
//            Image(systemName: "flame.fill")
//                .resizable()
//                .frame(width: 30, height: 35)
//                .foregroundStyle(LinearGradient(colors: [Color.orange, Color.red], startPoint: .topTrailing, endPoint: .bottomLeading))
            
            Image(.patas)
                .resizable()
                .frame(width: 50, height: 45)
        }
    }
}

struct VacinasView: View {
    var vacinasOrdenadas: [DoseDetalhada]
    var body: some View {
        NavigationLink {
            VacinaDetailView(vacinasOrdenadas: vacinasOrdenadas)
        } label: {
            VStack(spacing: 10) {
                //Header
                HStack {
                    Image(systemName: "medical.thermometer")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 16, weight: .semibold))
                    Text("Vacinas")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .foregroundStyle(.black)
                .padding([.top, .horizontal], 12)
                
                //Body
                
                if !vacinasOrdenadas.isEmpty {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Próxima")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color(red: 0.33, green: 0.69, blue: 0.85))
                            Text(vacinasOrdenadas.first!.nomeVacina)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.black)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text("Laboratório \(vacinasOrdenadas.first!.lab)\nLote \(vacinasOrdenadas.first!.lote)")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                            .padding(.bottom, 1)
                            
                            Text("\(vacinasOrdenadas.first!.dose.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
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
                    Text("Parece que você não adicionou uma próxima vacina!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                        .padding(15)
                        .padding(.bottom, 10)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
        }
    }
}

struct ConsultasView: View {
    var consultasOrdenadas: [ConsultaDetalhada]
    var body: some View {
        NavigationLink {
            ConsultaDetailView(consultasOrdenadas: consultasOrdenadas)
        } label: {
            VStack(spacing: 10) {
                //Header
                HStack {
                    Image(systemName: "stethoscope")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 16, weight: .semibold))
                    Text("Consultas")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .regular))
                }
                .foregroundStyle(.black)
                .padding([.top, .horizontal], 12)
                
                //Body
                
                if !consultasOrdenadas.isEmpty {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Próxima")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color(red: 0.33, green: 0.69, blue: 0.85))
                            Text(consultasOrdenadas.first!.title)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.black)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text(consultasOrdenadas.first!.location)
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                            .padding(.bottom, 1)
                            
                            Text("\(consultasOrdenadas.first!.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        
                        Image(uiImage: UIImage(data: consultasOrdenadas.first!.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 17)
                    .padding(.bottom, 12)
                } else {
                    Text("Parece que você não adicionou uma próxima consulta!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                        .padding(12)
                        .padding(.bottom, 10)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
        }
    }
}

struct RemediosView: View {
    var remediosOrdenados: [RemedioDetalhado]
    var body: some View {
        NavigationLink {
            RemedioDetailView(remediosOrdenados: remediosOrdenados)
        } label: {
            VStack(spacing: 10) {
                //Header
                HStack {
                    Image(systemName: "pill")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 16, weight: .semibold))
                    Text("Remédios")
                        .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .regular))
                }
                .foregroundStyle(.black)
                .padding([.top, .horizontal], 12)
                
                //Body
                
                if !remediosOrdenados.isEmpty {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Próxima")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(Color(red: 0.33, green: 0.69, blue: 0.85))
                            Text(remediosOrdenados.first!.name)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.black)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text("\(remediosOrdenados.first!.dose)\nAté \(remediosOrdenados.first!.endDate.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                            }
                            .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                            .padding(.bottom, 5)
                            
                            Text("\(remediosOrdenados.first!.startDate.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        
                        Image(uiImage: UIImage(data: remediosOrdenados.first!.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 17)
                    .padding(.bottom, 12)
                } else {
                    Text("Parece que você não adicionou um próximo remédio!")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(Color(red: 0.5, green: 0.5, blue: 0.5))
                        .padding(12)
                        .padding(.bottom, 10)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
        }
    }
}
