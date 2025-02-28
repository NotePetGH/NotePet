//
//  MainTabView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @AppStorage("isOnboardingCoverShowing") var isOnboardingCoverShowing = true
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
        .fullScreenCover(isPresented: $isOnboardingCoverShowing) {
            OnBoardingView()
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: Pet.self)
}

