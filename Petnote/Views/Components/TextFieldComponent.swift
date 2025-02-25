//
//  TextFieldComponent.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct TextFieldComponent: View {
    let title: String
    let textFieldTitle: String
    let spacing: Int
    @Binding var textInput: String
    var body: some View {
        VStack(alignment: .leading, spacing: CGFloat(spacing)) {
            Text(title)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            TextField(textFieldTitle, text: $textInput)
                .padding()
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
