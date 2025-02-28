//
//  EditCaminhadaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 27/02/25.
//

import SwiftUI

struct EditCaminhadaView: View {
    @Bindable var caminhada: Caminhada
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Clique para editar")
                .font(.title3.weight(.semibold))
                .padding(.vertical)
            // Nome da consulta
            TextFieldComponent(title: "Título", textFieldTitle: "Digite o título da consulta", spacing: 5, textInput: $caminhada.title)
            
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
                    
                    DatePicker("\(caminhada.date.formatted(date: .long, time: .omitted))", selection: $caminhada.date, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .padding()
                }
                .padding(.vertical, -4)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // Local da consulta
            
            // Observações
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

