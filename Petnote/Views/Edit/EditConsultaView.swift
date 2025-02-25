//
//  EditConsultaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 22/02/25.
//

import SwiftUI
import SwiftData

struct EditConsultaView: View {
    @Bindable var consulta: Consulta
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Clique para editar")
                .font(.title3.weight(.semibold))
                .padding(.vertical)
            // Nome da consulta
            TextFieldComponent(title: "Título", textFieldTitle: "Digite o título da consulta", spacing: 5, textInput: $consulta.title)
            
            // Data da consulta
            VStack(alignment: .leading, spacing: 5) {
                Text("Data")
                    .fontWeight(.medium)
                    .padding(.horizontal)
                HStack {
                    Text("Selecione data e hora")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemGray2))
                        .padding(.leading)
                    
                    Spacer()
                    
                    DatePicker("\(consulta.data.formatted(date: .long, time: .omitted))", selection: $consulta.data, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .padding()
                }
                .padding(.vertical, -4)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // Local da consulta
            TextFieldComponent(title: "Local", textFieldTitle: "Digite o local", spacing: 5, textInput: $consulta.location)
            
            // Observações
            TextFieldComponent(title: "Observações", textFieldTitle: "Digite alguma observação (opcional)", spacing: 5, textInput: Binding(
                get: { consulta.obs ?? "" },  // Se for nil, retorna uma string vazia
                set: { consulta.obs = $0 }    // Define o valor opcional com o texto
            ))
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Pet.self, configurations: config)
        let example = Consulta(title: "Consulta", data: .now, location: "Rua", obs: "Casa")
        return EditConsultaView(consulta: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create")
    }
    
}
