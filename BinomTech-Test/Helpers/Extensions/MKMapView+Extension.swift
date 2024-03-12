//
//  MKMapView+Extension.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 12.03.2024.
//

import MapKit
extension MKMapView {
    var zoomLevel: Double {
        return log2(360 * ((Double(self.frame.size.width) / 256) / self.region.span.longitudeDelta)) - 1
    }
}
