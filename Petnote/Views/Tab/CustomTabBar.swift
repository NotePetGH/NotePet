//
//  CustomTabBar.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

//struct CustomTabBar: View {
//    @Binding var selectedTab: Tabs
//    var body: some View {
//        VStack(spacing: 10) {
//            HStack(spacing: 40) {
//                Button {
//                    selectedTab = .resume
//                } label: {
//                    VStack(spacing: 2) {
//                        Image(systemName: "circle.grid.2x2.fill")
//                            .foregroundStyle(selectedTab == .resume ? .yellow : Color(.systemGray2))
//                        Text("Acompanhar")
//                            .foregroundStyle(selectedTab == .resume ? .black : Color(.systemGray2))
//                    }
//                    .font(.system(size: 16))
//                }
//                Button {
//                    selectedTab = .pets
//                } label: {
//                    VStack(spacing: 2) {
//                        Image(systemName: "pawprint.fill")
//                            .foregroundStyle(selectedTab == .pets ? .yellow : Color(.systemGray2))
//                        Text("Meus bichos")
//                            .foregroundStyle(selectedTab == .pets ? .black : Color(.systemGray2))
//                    }
//                    .font(.system(size: 16))
//                }
//                Button {
//                    selectedTab = .ajustes
//                } label: {
//                    VStack(spacing: 2) {
//                        Image(systemName: "gearshape")
//                            .foregroundStyle(selectedTab == .ajustes ? .yellow : Color(.systemGray2))
//                        Text("Ajustes")
//                            .foregroundStyle(selectedTab == .ajustes ? .black : Color(.systemGray2))
//                    }
//                    .font(.system(size: 16))
//                }
//                
//                
//            }
//        }
//    }
//}
//
//#Preview {
//    CustomTabBar(selectedTab: .constant(.pets))
//}
