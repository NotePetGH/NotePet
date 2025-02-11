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
                        .stroke(Color(red: 1, green: 0.91, blue: 0.49), lineWidth: 1.5)
                }
        }
    }
}
