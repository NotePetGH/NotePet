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
                // Nome da vacina
                TextFieldComponent(title: "Título", textFieldTitle: "Digite o título da consulta", spacing: 5, textInput: $title)
                
                // Data da vacina
                VStack(alignment: .leading, spacing: 5) {
                    Text("Data")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    HStack {
                        DatePicker("\(data.formatted(date: .long, time: .omitted))", selection: $data, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
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
