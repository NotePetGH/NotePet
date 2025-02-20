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
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color(red: 0.22, green: 0.31, blue: 0.45), lineWidth: 1.5)
                }
        }
    }
}
