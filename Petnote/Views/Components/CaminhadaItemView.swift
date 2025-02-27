//
//  CaminhadaItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI
import MapKit

struct CaminhadaItemView: View {
    var caminhada: Caminhada
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(caminhada.title)
                    .font(.system(size: 20, weight: .regular))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(Int(caminhada.distance)) m")
                    Text("\(Int(caminhada.time / 60)) min")
                    
                }
                .font(.system(size: 15))
                
            }
            Spacer()
            Map {
                MapPolyline(coordinates: caminhada.decodedRoute())
                    .stroke(.blue, lineWidth: 5)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    CaminhadaItemView(caminhada: Caminhada(title: "Passeio matinal", distance: 20, time: 12, date: .now, route: []))
}
