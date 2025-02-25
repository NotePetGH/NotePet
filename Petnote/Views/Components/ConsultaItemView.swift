//
//  ConsultemItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct ConsultaItemView: View {
    var consulta: Consulta
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(consulta.title)
                    .font(.system(size: 20, weight: .regular))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(consulta.location)
                    Text(consulta.data.formatted(date: .numeric, time: .standard))
                    
                }
                .font(.system(size: 15))
                
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
    ConsultaItemView(consulta: Consulta(title: "Consulta Dr. Fritz", data: .now, location: "Rua das Carnaúbas, 346", obs: "Levar cartão de vacina"))
}
