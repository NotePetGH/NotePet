//
//  SaudeDetailedView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI
enum Views {
    case remedios
    case vacinas
    case consultas
}
struct SaudeDetailView: View {
    @State var selectedView: Views = .vacinas
    @Environment(\.presentationMode) var presentationMode
    var pet: Pet
    @State var showSheet = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 33) {
                    Text("Remédios")
                        .font(.system(size: 14, weight: .medium))
                        .padding(12)
                        .background(selectedView == .remedios ? Color(red: 1, green: 0.91, blue: 0.49) : Color(red: 0.98, green: 0.98, blue: 0.98))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            selectedView = .remedios
                        }
                    Text("Vacinas")
                        .font(.system(size: 14, weight: .medium))
                        .padding(12)
                        .background(selectedView == .vacinas ? Color(red: 1, green: 0.91, blue: 0.49) : Color(red: 0.98, green: 0.98, blue: 0.98))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            selectedView = .vacinas
                        }
                    Text("Consultas")
                        .font(.system(size: 14, weight: .medium))
                        .padding(12)
                        .background(selectedView == .consultas ? Color(red: 1, green: 0.91, blue: 0.49) : Color(red: 0.98, green: 0.98, blue: 0.98))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            selectedView = .consultas
                        }
                }
                .padding(.top)
                Spacer().frame(height: 15)
                ScrollView {
                    Spacer().frame(height: 30)
                    VStack(spacing: 20) {
                        if selectedView == .vacinas {
                            ForEach(pet.vacinas) { vacina in
                                VacinaItemView(vacina: vacina)
                            }
                        } else if selectedView == .consultas {
                            ForEach(pet.consultas) { consulta in
                                ConsultaItemView(consulta: consulta)
                            }
                        } else if selectedView == .remedios {
                            ForEach(pet.remedios) { remedio in
                                RemedioItemView(remedio: remedio)
                            }
                        }
                        
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 16)
            }
            .navigationTitle("Saúde")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) // Esconde o botão padrão
                    .navigationBarItems(leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .fontWeight(.semibold)
                            Text("Voltar")
                        }
                    })
            
        }
        .overlay(alignment: .bottomTrailing) {
           
            Button {
                showSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.black)
                    .padding(14)
                    .background(Color(red: 1, green: 0.91, blue: 0.49), in: Circle())
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .sheet(isPresented: $showSheet) {
                if selectedView == .vacinas {
                    AddVacinaView(pet: pet)
                        .presentationDetents([.height(500)])
                        .presentationDragIndicator(.visible)
                } else if selectedView == .consultas {
                    AddConsultaView(pet: pet)
                        .presentationDetents([.height(500)])
                        .presentationDragIndicator(.visible)
                } else if selectedView == .remedios {
                    AddRemedioView(pet: pet)
                        .presentationDetents([.height(500)])
                        .presentationDragIndicator(.visible)
                }
               
                
            }
        }
    }
}

#Preview {
    SaudeDetailView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: []))
}
