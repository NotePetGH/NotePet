//
//  VacinaRowItemView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 16/02/25.
//

import SwiftUI

struct DoseDetalhadaRowView: View {
    var dose: DoseDetalhada
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: dose.image)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .clipShape(Circle())
            Text(dose.nomeVacina)
                .font(.system(size: 14))
                .foregroundStyle(.black)
            Spacer()
            Text("\(dose.dose.data.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits)))")
                .foregroundStyle(.gray)
            
        }
    }
}

