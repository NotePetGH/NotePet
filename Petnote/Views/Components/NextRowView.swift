//
//  NextRemedioView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 22/02/25.
//

import SwiftUI

struct NextRowView: View {
    var icon: String
    var title: String
    var name: String
    var firstLine: String
    var secondLine: String
    var time: String
    var body: some View {
        VStack(spacing: 10) {
            //Header
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .regular))
            }
            .foregroundStyle(.black)
            .padding([.top, .horizontal], 12)
            
            //Body
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Próxima")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.accent.opacity(0.6))
                    Text(name)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.accent)
                    HStack(spacing: 6) {
                        Divider().frame(height: 24)
                        Text("\(firstLine)\n\(secondLine)")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 5)
                    
                    Text(time)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                }
                Spacer()
                
                HStack(spacing: -15) {
                    Circle().frame(width: 50)
                    Circle().frame(width: 50)
                }
            }
            .padding(.horizontal, 17)
            .padding(.bottom, 12)
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    NextRowView(icon: "Pill", title: "Remédios", name: "Torzemin", firstLine: "10mg", secondLine: "Todos os dias", time: "12h - 12h")
}
