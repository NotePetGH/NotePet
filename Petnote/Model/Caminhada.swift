//
//  Caminhada.swift
//  Petnote
//
//  Created by João Marcelo Colombini Cardonha on 20/02/25.
//

import Foundation
import SwiftData
import MapKit

@Model
class Caminhada: Identifiable {
    var title: String
    var distance: Double
    var time: TimeInterval
    var date: Date
    var routeData: Data?
    var pets: [Pet] = []

    init(title: String, distance: Double, time: TimeInterval, date: Date, route: [CLLocationCoordinate2D]) {
        self.title = title
        self.distance = distance
        self.time = time
        self.date = date
        self.routeData = Caminhada.encodeRoute(route)
    }

    static func encodeRoute(_ route: [CLLocationCoordinate2D]) -> Data? {
        let codableRoute = route.map { CodableCoordinate(latitude: $0.latitude, longitude: $0.longitude) }
        return try? JSONEncoder().encode(codableRoute)
    }

    func decodedRoute() -> [CLLocationCoordinate2D] {
        guard let routeData else { return [] }
        let codableRoute = (try? JSONDecoder().decode([CodableCoordinate].self, from: routeData)) ?? []
        return codableRoute.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
    }
}

struct CodableCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}
