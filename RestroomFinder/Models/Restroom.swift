//
//  Restroom.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/14/23.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

struct Restroom: Decodable, Identifiable, Equatable {
    
    let id: Int
    let name: String
    let street: String
    let city: String
    let state: String
    let comment: String?
    let accessible: Bool
    let unisex: Bool
    let changingTable: Bool
    let latitude: Double
    let longitude: Double
    
    var address: String {
        "\(street), \(city) \(state)"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // CodingKeys is our mapping to the API property names.  i.e. - we want our internal var to be camelCase
    enum CodingKeys: String, CodingKey, Decodable {
        
        case id
        case name
        case street
        case city
        case state
        case comment
        case accessible
        case unisex
        case changingTable = "changing_table"
        case latitude
        case longitude
    }
    


}
// TODO: why does it need to be an extension vs just another computed property iin the struct?
// extend so it works with our ActionButtons (which need an MKMapItem).  import mapkit too.
extension Restroom {
    var mapItem: MKMapItem {
        
        var addressDictionary: [String: Any] = [
            CNPostalAddressStreetKey: self.street,
            CNPostalAddressCityKey: self.city,
            CNPostalAddressStateKey: self.state
        ]
        
        // create a computed property.  make an address, make a placemark, make a mapItem
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}
