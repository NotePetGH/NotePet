//
//  ExploreView.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 13/02/25.
//

import SwiftUI
import MapKit

struct ExploreView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var mapSelection: MKMapItem?
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    var body: some View {
        NavigationView {
            ZStack {
                Map(position: $cameraPosition, selection: $mapSelection) {
                    Marker(coordinate: CLLocationCoordinate2D(latitude: -3.8021155267932967, longitude: -38.53418264271533)) {
                        Label("Lecoland Petshop", systemImage: "cart")
                    }
                    Marker(coordinate: CLLocationCoordinate2D(latitude: -3.744315029667117, longitude: -38.48598003917655)) {
                        Label("Parque do Cocó", systemImage: "tree")
                    }
                    .tint(.green)
                    Marker(coordinate: CLLocationCoordinate2D(latitude: -3.812222866009952, longitude: -38.61884297611294)) {
                        Label("Abrigo São Lázaro", systemImage: "house")
                    }
                    .tint(.blue)
                    
                    ForEach(results, id: \.self) { item in
                        let placemark = item.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                    
                }
                    .onAppear {
                        let fortaleza = CLLocationCoordinate2D(latitude: -3.7339498333667764, longitude: -38.528211002222754)
                        let fortalezaSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                        let fortalezaregion = MKCoordinateRegion(center: fortaleza, span: fortalezaSpan)
                        
                        cameraPosition = .region(fortalezaregion)
                }
                    
                
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(height:155).foregroundStyle(.white).shadow(color: .black.opacity(0.07), radius: 2, x: 0, y: 2)
                        HStack {
                            Text("Explorar")
                                .font(.system(size: 34, weight: .semibold))
                            
                            Spacer()
                            
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .imageScale(.large)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal)
                        .padding(.top, 60)
                    }
                    Spacer()
                    HStack {
                        Button("Petshops") {
                            searchText = "pet shop"
                            Task { await searchPlaces()}
                        }
                        Button("parques") {
                            searchText = "parque"
                            Task { await searchPlaces()}
                        }
                    }
                }
                .ignoresSafeArea().navigationBarHidden(true)
            }
        }
    }
}
extension ExploreView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
}
#Preview {
    ExploreView()
}
