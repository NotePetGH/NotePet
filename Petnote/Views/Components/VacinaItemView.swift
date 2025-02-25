//
//  VacinaItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct VacinaItemView: View {
    var vacina: Vacina
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(vacina.name)
                    .font(.system(size: 20, weight: .regular))
                
                ForEach(vacina.doses) { dose in
                    HStack(spacing: 8) {
                        Text(dose.data.formatted(date: .numeric, time: .omitted))
                        Image(systemName: dose.isPending ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
                            .foregroundStyle(Color(red: 0.2, green: 0.74, blue: 0.17))
                    }
                }
            }
            
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}


#Preview {
    VacinaItemView(vacina: Vacina(name: "Raiva", lote: "1", lab: "Vitality", doses: [Dose(data: .now, isPending: false), Dose(data: .distantFuture, isPending: true)]))
}
