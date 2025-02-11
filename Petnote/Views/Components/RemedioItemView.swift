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
        VStack(alignment: .leading, spacing: 10) {
            Text(remedio.name)
                .font(.system(size: 20, weight: .regular))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(remedio.startDate.formatted(date: .numeric, time: .standard))
                Text("\(remedio.dose) comprimidos")
                
            }
            .font(.system(size: 15))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    RemedioItemView(remedio: Remedio(name: "Gardernal", unity: "g", dose: 1, frequency: DateInterval(start: .now, duration: 3600), startDate: .now, interval: DateInterval(start: .now, duration: 3600), intervalBetweenDays: DateInterval(start: .now, duration: 3600)))
}
