//
//  LocationsDataService.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import Foundation
import MapKit
class LocationsDataService {
    static let locations: [Location] = [
        Location(
            firstName: "Александр",
            lastName: "Горелкин",
            coordinates: CLLocationCoordinate2D(latitude: 55.740274, longitude: 37.417497)),
        Location(
            firstName: "Яна",
            lastName: "Ванцова",
            coordinates: CLLocationCoordinate2D(latitude: 55.810423, longitude: 37.396147)),
        Location(
            firstName: "Николь",
            lastName: "Садыкова",
            coordinates: CLLocationCoordinate2D(latitude: 55.852829, longitude: 37.698645)),
        Location(
            firstName: "Артем",
            lastName: "Гуев",
            coordinates: CLLocationCoordinate2D(latitude: 55.590776, longitude: 37.597972)),
        Location(
            firstName: "Юлия",
            lastName: "Цурикова",
            coordinates: CLLocationCoordinate2D(latitude: 55.692440, longitude: 37.620429))
    ]
}

