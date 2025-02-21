//
//  ItemModifier.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import Foundation
import SwiftUICore

struct ItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(11)
        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color(red: 0.01, green: 0.01, blue: 0.01).opacity(0.07), radius: 2, x: 0, y: 2)
    }
}
