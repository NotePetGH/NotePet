//
//  AddCaminhadaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI
import SwiftData

struct AddCaminhadaView: View {
    var pet: Pet
    @State var title = ""
    @State var distance = ""
    @State var time = ""
    @State var date = Date()
    @State private var duration = DateComponents(minute: 0, second: 0)
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Text("Salvar")
                    .foregroundStyle(.white)
                Spacer()
                Text("Adicionar caminhada")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button {
//                    var caminhada = Caminhada(title: title, distance: Int(distance)!, time: Int(time)!, date: date)
//                    pet.caminhadas.append(caminhada)
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.accent)
                }
                
            }
            .padding()
            
            VStack(spacing: 12) {
                TextFieldComponent(title: "Título", textFieldTitle: "Digite o título da caminhada", spacing: 5, textInput: $title)
                TextFieldComponent(title: "Distância", textFieldTitle: "Digite a distância percorrida (m)", spacing: 5, textInput: $distance).keyboardType(.numberPad)
                
                TextFieldComponent(title: "Tempo", textFieldTitle: "Digite a duração (min)", spacing: 5, textInput: $time).keyboardType(.numberPad)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Data")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    HStack {
                        Text("Selecione data e hora")
                            .font(.body)
                            .foregroundStyle(Color(.systemGray2))
                            .padding(.leading)
                        
                        Spacer()
                        
                        DatePicker("\(date.formatted(date: .long, time: .omitted))", selection: $date, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .padding()
                    }
                    .padding(.vertical, -4)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            
            .padding(.top, 30)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    AddCaminhadaView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: [], caminhadas: []))
}
