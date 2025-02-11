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
    @State var unity = 1
    @State var dose: String = ""
    @State var frequency: DateInterval = .init(start: .now, end: .distantFuture)
    @State var startDate: Date = .now
    @State var interval: DateInterval = .init(start: .now, end: .distantFuture)
    @State var intervalBetweenDays: DateInterval = .init(start: .now, end: .distantFuture)
    
    func convertUnity(_ number: Int) -> String {
        switch number {
        case 1:
            return "mg"
        case 2:
            return "g"
        default:
            return "Não especificado"
        }
    }
    
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
                    var remedio = Remedio(name: name, unity: convertUnity(unity), dose: Int(dose) ?? 10, frequency: frequency, startDate: startDate, interval: interval, intervalBetweenDays: intervalBetweenDays)
                    pet.remedios.append(remedio)
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                }
                
            }
            .padding()
            
            
            VStack(spacing: 12) {
                // Nome do remédio
                TextFieldComponent(title: "Remédio", textFieldTitle: "Digite o nome do remédio", spacing: 5, textInput: $name)
                
                // Picker de dosagem
                VStack(alignment: .leading, spacing: 5) {
                    Text("Unidade de dosagem")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Selecione uma unidade")
                            .foregroundStyle(.tertiary)
                            .padding()
                        Spacer()
                        Picker("", selection: $unity) {
                            Text("mg").tag(1)
                            Text("g").tag(2)
                        }
                        .tint(Color(red: 0.75, green: 0.49, blue: 0))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color(red: 1, green: 0.91, blue: 0.49), lineWidth: 1.5)
                    }
                }
                
                // Dosagem do remédio
                TextFieldComponent(title: "Dosagem", textFieldTitle: "Digite a dosagem", spacing: 5, textInput: $dose)
                
                // Data de Início
                VStack(alignment: .leading, spacing: 5) {
                    Text("Data de início")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    HStack {
                        DatePicker("\(startDate.formatted(date: .long, time: .omitted))", selection: $startDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .padding(.horizontal)
                            .foregroundStyle(Color(red: 0.75, green: 0.49, blue: 0))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color(red: 1, green: 0.91, blue: 0.49), lineWidth: 1.5)
                    }
                }
                
                
                
                // Frequência                
                
            }
            .padding(.top, 48)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    AddRemedioView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: []))
}
