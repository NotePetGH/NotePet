//
//  EditRemedioView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 22/02/25.
//

import SwiftUI
import SwiftData

struct EditRemedioView: View {
    @Bindable var remedio: Remedio
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Clique para editar")
                .font(.title3.weight(.semibold))
                .padding(.vertical)
            // Nome do remédio
            TextFieldComponent(title: "Remédio", textFieldTitle: "Digite o nome do remédio", spacing: 5, textInput: $remedio.name)
            
            // Picker de dosagem
            
            // Dosagem do remédio
            TextFieldComponent(title: "Dosagem", textFieldTitle: "Digite a dosagem", spacing: 5, textInput: $remedio.dose)
            
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
                        DatePicker("\(remedio.startDate.formatted(date: .long, time: .omitted))", selection: $remedio.startDate, in: Date()..., displayedComponents: .date)
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
                        DatePicker("\(remedio.endDate.formatted(date: .long, time: .omitted))", selection: $remedio.endDate, in: Date()..., displayedComponents: .date)
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
                
                TextField("Digite quantas vezes ao dia", text: $remedio.quantityPerDay)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Pet.self, configurations: config)
        let example = Remedio(name: "Gardernal", dose: "Comprimido - 10mg", startDate: .now, endDate: .distantFuture, quantityPerDay: "2")
        return EditRemedioView(remedio: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create")
    }
    
}
