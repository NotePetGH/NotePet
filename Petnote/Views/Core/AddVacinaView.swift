//
//  AddVacinaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct AddVacinaView: View {
    var pet: Pet
    @State var name = ""
    @State var lote = ""
    @State var lab = ""
    @State var data = Date()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Text("Salvar")
                    .foregroundStyle(.white)
                Spacer()
                Text("Adicionar vacina")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button {
                    var vacina = Vacina(name: name, lote: lote, lab: lab, doses: [Dose(data: data, isPending: false)])
                    pet.vacinas.append(vacina)
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
                TextFieldComponent(title: "Vacina", textFieldTitle: "Digite o nome da vacina", spacing: 5, textInput: $name)
                
                // Data da vacina
                VStack(alignment: .leading, spacing: 5) {
                    Text("Data")
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    HStack {
                        DatePicker("\(data.formatted(date: .long, time: .omitted))", selection: $data, in: ...Date(), displayedComponents: .date)
                            .labelsHidden()
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "calendar")
                            .padding(.horizontal)
                            .foregroundStyle(Color(red: 0.22, green: 0.31, blue: 0.45))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color(red: 0.22, green: 0.31, blue: 0.45), lineWidth: 1.5)
                    }
                }
                
                // Lote da vacina
                TextFieldComponent(title: "Lote", textFieldTitle: "Digite o lote", spacing: 5, textInput: $lote)
                
                // Laboratório da vacina
                TextFieldComponent(title: "Laboratório", textFieldTitle: "Digite o laboratório", spacing: 5, textInput: $lab)
                
                
            }
            .padding(.top, 48)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    AddVacinaView(pet: Pet(name: "Mite", age: 1, imageURL: .mite, animal: "Gato", gender: "Macho", vacinas: [], consultas: [], remedios: []))
}

