//
//  MapCameraPosition+Extension.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/21/23.
//

import Foundation
import MapKit
import SwiftUI
// apparently MapCameraPosition is in SwiftUI, not MapKit

extension MapCameraPosition {
    
    static var apple: MapCameraPosition {
        .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3348826008422, longitude: -122.00899344992547), latitudinalMeters: 100, longitudinalMeters: 100))
    }
}
