//
//  EditVacinaView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 22/02/25.
//

import SwiftUI
import SwiftData

struct EditVacinaView: View {
    @Bindable var vacina: Vacina
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Clique para editar")
                .font(.title3.weight(.semibold))
                .padding(.vertical)
            // Nome da vacina
            TextFieldComponent(title: "Vacina", textFieldTitle: "Digite o nome da vacina", spacing: 5, textInput: $vacina.name)
            
            // Data da vacina
            VStack(alignment: .leading, spacing: 5) {
                Text("Data")
                    .fontWeight(.medium)
                    .padding(.horizontal)
                HStack {
                    Text("Data de início")
                        .padding(.leading)
                        .foregroundStyle(.tertiary)
                    Spacer()
                    DatePicker("\(vacina.doses[0].data.formatted(date: .long, time: .omitted))", selection: $vacina.doses[0].data, in: ...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .padding()
                }
                .padding(.vertical, -4)
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            // Lote da vacina
            TextFieldComponent(title: "Lote", textFieldTitle: "Digite o lote", spacing: 5, textInput: $vacina.lote)
            
            // Laboratório da vacina
            TextFieldComponent(title: "Laboratório", textFieldTitle: "Digite o laboratório", spacing: 5, textInput: $vacina.lab)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        
    }
}
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Pet.self, configurations: config)
        let example = Vacina(name: "Raiva", lote: "dez", lab: "doze", doses: [Dose(data: .now, isPending: false)])
        return EditVacinaView(vacina: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create")
    }
    
}

