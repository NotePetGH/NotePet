//
//  CaminhadaItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 26/02/25.
//

import SwiftUI
import MapKit

struct CaminhadaItemView: View {
    func formatarTempo(segundos: Int) -> String {
        let minutos = segundos / 60
        let segundosRestantes = segundos % 60
        return String(format: "%02d'%02d''", minutos, segundosRestantes)
    }
    var caminhada: Caminhada
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 25) {
                Text("\(caminhada.date.formatted(date: .numeric, time: .shortened))")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(Color(red: 0, green: 0.35, blue: 0.49))
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Image(systemName: "shoeprints.fill")
                        Text("\(Int(caminhada.distance)) m")
                            .foregroundStyle(.black)
                    }
                    .font(.system(size: 18, weight: .regular))
                    HStack(spacing: 4) {
                        Image(systemName: "timer")
                        Text("\(formatarTempo(segundos: Int(caminhada.time)))")
                            .foregroundStyle(.black)
                    }
                    .font(.system(size: 18, weight: .regular))
                    
                    
                }
                .font(.system(size: 15))
                Spacer()
                
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
            Map {
                MapPolyline(coordinates: caminhada.decodedRoute())
                    .stroke(.blue, lineWidth: 5)
            }
            .frame(width: 160, height: 160)
            .cornerRadius(15)
        }
        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding()
    }
}

#Preview {
    CaminhadaItemView(caminhada: Caminhada(title: "Passeio matinal", distance: 20, time: 12, date: .now, route: []))
}
