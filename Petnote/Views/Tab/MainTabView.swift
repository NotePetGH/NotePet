//
//  MainTabView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Binding var show: Bool
    var body: some View {
        TabView {
            ResumeView()
                .tabItem {
                    Image(systemName: "circle.grid.2x2")
                    Text("Resumo")
                }
            MyPetsView()
                .tabItem {
                    Image(systemName: "pawprint")
                    Text("Meus pets")
                }
            ExploreView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Explorar")
                }
        }
    }
}

#Preview {
    MainTabView(show: .constant(true))
        .modelContainer(for: Pet.self, inMemory: true)
}

