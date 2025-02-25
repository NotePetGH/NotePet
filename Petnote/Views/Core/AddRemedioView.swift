//
//  AddRemedioView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 11/02/25.
//

import SwiftUI

struct AddRemedioView: View {
    @Environment(\.dismiss) var dismiss
    var pet: Pet
    @State var name = ""
    @State var dose: String = ""
    @State var startDate: Date = .now
    @State var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: .now)!
    @State var quantityPerDay: String = ""
    
    var body: some View {
        VStack {
            // Barra superior
            HStack {
                Text("Salvar")
                    .foregroundStyle(.white)
                Spacer()
                Text("Adicionar remédio")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button {
                    var remedio = Remedio(name: name, dose: dose, startDate: startDate, endDate: endDate, quantityPerDay: quantityPerDay)
                    pet.remedios.append(remedio)
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            
            ScrollView {
                VStack(spacing: 12) {
                    // Nome do remédio
                    TextFieldComponent(title: "Remédio", textFieldTitle: "Digite o nome do remédio", spacing: 5, textInput: $name)
                    
                    // Picker de dosagem
                    
                    // Dosagem do remédio
                    TextFieldComponent(title: "Dosagem", textFieldTitle: "Digite a dosagem", spacing: 5, textInput: $dose)
                    
                    // Data de Início
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Período")
                            .fontWeight(.medium)
                            .padding(.horizontal)
                        VStack(spacing: 10) {
                            HStack {
                                Text("Data de início")
                                    .foregroundStyle(.tertiary)
                                
                                Spacer()
                                DatePicker("\(startDate.formatted(date: .long, time: .omitted))", selection: $startDate, in: Date()..., displayedComponents: .date)
                                    .labelsHidden()
                                
                            }
                            .padding(.horizontal)
                            .padding(.top, 14)
                            
                            Divider()
                                .padding(.horizontal)
                            
                            HStack {
                                
                                Text("Data de fim")
                                    .foregroundStyle(.tertiary)
                                
                                Spacer()
                                DatePicker("\(endDate.formatted(date: .long, time: .omitted))", selection: $endDate, in: Date()..., displayedComponents: .date)
                                    .labelsHidden()
                                
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 14)
                            
                        }
                        .padding(.vertical, -4)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Vezes ao dia")
                            .fontWeight(.medium)
                            .padding(.horizontal)
                        
                        TextField("Digite quantas vezes ao dia", text: $quantityPerDay)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    
                    // Frequência                
                    
                }
                .padding(.top, 48)
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    AddRemedioView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: []))
}
