//
//  AddConsultaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct AddConsultaView: View {
    var pet: Pet
    @State var data = Date()
    @State var title = ""
    @State var location = ""
    @State var obs = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Text("Salvar")
                    .foregroundStyle(.white)
                Spacer()
                Text("Adicionar consulta")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button {
                    var consulta = Consulta(title: title, data: data, location: location, obs: obs)
                    pet.consultas.append(consulta)
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                }
                
            }
            .padding()
            
            
            VStack(spacing: 12) {
                // Nome da consulta
                TextFieldComponent(title: "Título", textFieldTitle: "Digite o título da consulta", spacing: 5, textInput: $title)
                
                // Data da consulta
                VStack(alignment: .leading, spacing: 5) {
                    Text("Data")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    HStack {
                        Text("Selecione data e hora")
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.leading)
                        
                        Spacer()
                        
                        DatePicker("\(data.formatted(date: .long, time: .omitted))", selection: $data, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                            .padding()
                    }
                    .padding(.vertical, -4)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                // Local da consulta
                TextFieldComponent(title: "Local", textFieldTitle: "Digite o local", spacing: 5, textInput: $location)
                
                // Observações
                TextFieldComponent(title: "Observações", textFieldTitle: "Digite alguma observação (opcional)", spacing: 5, textInput: $obs)
                
                
            }
            .padding(.top, 48)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    AddConsultaView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: []))
}
