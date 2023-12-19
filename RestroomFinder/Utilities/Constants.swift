//
//  Constants.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/17/23.
//

import Foundation

struct Constants {
    // an inner struct
    struct Urls {
        static func restroomsByLocation (latitude: Double, longitude: Double) -> URL {
            // unwrap the URL
                return URL(string: "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=\(latitude)&lng=\(longitude)")!
        
        }
    }
}
