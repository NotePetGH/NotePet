//
//  MainTabView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 10/02/25.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: Tabs = .pets
    @Binding var show: Bool
    var body: some View {
        if selectedTab == .pets {
            MyPetsView()
        } else if selectedTab == .ajustes {
            SettingsView()
        }
        CustomTabBar(selectedTab: $selectedTab)
    }
}

#Preview {
    MainTabView(show: .constant(true))
}

enum Tabs: Int {
    case pets = 0
    case ajustes = 1
}

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing)
                    VStack(alignment: .leading) {
                        Text("User")
                        Text("Entre ou crie uma conta")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                }
                .padding(.horizontal, 22)
                .frame(height: 80)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                
                VStack {
                    HStack {
                        Text("Notificações")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.top, 4)
                    Divider()
                    HStack {
                        Text("Acessibilidade")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.top, 4)
                    Divider()
                    HStack {
                        Text("Ajuda e suporte")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.top, 4)
                    Divider()
                    HStack {
                        Text("Sobre o aplicativo")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.top, 4)
                }
                .padding()
                .frame(height: 180)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                Spacer()
            }
            .padding()
            .navigationTitle("Ajustes")
            
        }
    }
}

#Preview {
    SettingsView()
}
