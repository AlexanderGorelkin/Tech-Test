//
//  Location.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let firstName: String
    let lastName: String
    let coordinates: CLLocationCoordinate2D
    
    //MARK: - Identifiable
    var id: String {
        return firstName + " " + lastName
    }
    
    //MARK: - Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
