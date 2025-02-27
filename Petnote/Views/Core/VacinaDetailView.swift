//
//  VacinaDetailView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI

struct VacinaDetailView: View {
    var vacinasOrdenadas: [DoseDetalhada]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vacinasOrdenadas) { vacina in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(vacina.nomeVacina)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.accent)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text("Laboratório \(vacina.lab)\nLote \(vacina.lote)")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.bottom, 1)
                            
                            Text("\(vacina.dose.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        
                        Image(uiImage: UIImage(data: vacina.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 17)
                    .padding(.bottom, 2)
                    Divider()
                }
            }
            .navigationTitle("Próximas vacinas")
            .padding()
        }
    }
}
struct ConsultaDetailView: View {
    var consultasOrdenadas: [ConsultaDetalhada]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(consultasOrdenadas) { consulta in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(consulta.title)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.accent)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text("Laboratório \(consulta.location)")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.bottom, 1)
                            
                            Text("\(consulta.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        
                        Image(uiImage: UIImage(data: consulta.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 17)
                    .padding(.bottom, 2)
                    Divider()
                }
            }
            .navigationTitle("Próximas consultas")
            .padding(.horizontal)
        }
    }
}
struct RemedioDetailView: View {
    var remediosOrdenados: [RemedioDetalhado]
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer().frame(height: 20)
                ForEach(remediosOrdenados) { remedio in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(remedio.name)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.accent)
                            HStack(spacing: 6) {
                                Divider().frame(height: 20)
                                Text("\(remedio.dose)\nAté \(remedio.endDate.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.bottom, 1)
                            
                            Text("\(remedio.startDate.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        
                        Image(uiImage: UIImage(data: remedio.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 17)
                    .padding(.bottom, 2)
                    Divider()
                }
            }
            .navigationTitle("Próximos remédios")
            .padding(.horizontal)
        }
    }
}
#Preview {
    VacinaDetailView(vacinasOrdenadas: [])
}
