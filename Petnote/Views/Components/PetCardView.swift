//
//  PetCardView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//
import SwiftUI

struct PetCardView: View {
    var imageURL: UIImage
    var petName: String
    
    var body: some View {
        Image(uiImage: imageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 160, height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .background(Color.clear)
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Text(petName)
                            .font(.system(size: 22))
                        Spacer()
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 9)
                .font(.largeTitle)
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
    }
}
