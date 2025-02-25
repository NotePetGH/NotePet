//
//  RemedioItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 11/02/25.
//

import SwiftUI

struct RemedioItemView: View {
    var remedio: Remedio
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(remedio.name)
                    .font(.system(size: 20, weight: .regular))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(remedio.startDate.formatted(date: .numeric, time: .shortened))
                    Text("\(remedio.dose) comprimidos")
                    
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
    RemedioItemView(remedio: Remedio(name: "Gadernal", dose: "10mg", startDate: .now, endDate: .distantFuture, quantityPerDay: "2"))
}
