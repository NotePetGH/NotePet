//
//  ConsultaRowItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 16/02/25.
//

import SwiftUI

struct ConsultaRowItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text("Cardiograma")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
                Spacer()
                Circle().frame(width: 20)
                    .foregroundStyle(.black)
            }
            Text("Av. Eng. Luciano Cavalcante 187")
                .font(.system(size: 10))
                .multilineTextAlignment(.leading)
                .frame(width: 80)
                .foregroundStyle(Color(red: 0.68, green: 0.68, blue: 0.68))
            Text("16/02")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(red: 0.22, green: 0.31, blue: 0.45))
                .padding(.top, 6)
                .padding(.bottom, 10)
            
            Divider()
        }
        
        .padding(.top, 5)
    }
}

#Preview {
    ConsultaRowItemView()
}
