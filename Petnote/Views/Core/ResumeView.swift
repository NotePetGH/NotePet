//
//  ResumeView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 13/02/25.
//

import SwiftUI

struct ResumeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 15)
                HStack {
                    Text("Meus bichos")
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    
                }
                .padding(16)
                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink {
                            
                        } label: {
                            Text("OI")
                                .font(.system(size: 24))
                                .foregroundStyle(.black)
                                .padding(17)
                                .frame(width: 350, height: 125, alignment: .topLeading)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        HStack(spacing: 20) {
                            VStack(spacing: 20) {
                                NavigationLink {
                                    
                                } label: {
                                    Text("OI")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                        .padding(17)
                                        .frame(width: 165, height: 150, alignment: .topLeading)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                NavigationLink {
                                    
                                } label: {
                                    Text("OI")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                        .padding(17)
                                        .frame(width: 165, height: 237, alignment: .topLeading)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            VStack(spacing: 20) {
                                NavigationLink {
                                    
                                } label: {
                                    Text("OI")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                        .padding(17)
                                        .frame(width: 165, height: 237, alignment: .topLeading)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                NavigationLink {
                                    
                                } label: {
                                    Text("OI")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.black)
                                        .padding(17)
                                        .frame(width: 165, height: 150, alignment: .topLeading)
                                        .background(Color(.systemGray5))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                    }
                    
                   
                }
            }
        }
    }
}

#Preview {
    ResumeView()
}
