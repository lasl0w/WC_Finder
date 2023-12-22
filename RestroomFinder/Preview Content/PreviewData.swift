//
//  PreviewData.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/19/23.
//

import Foundation

struct PreviewData {
    
    // TODO: - tut on generic functions, usage of <T>
    static func load<T: Decodable>(resourceName: String) -> T {
        // TODO: tut on Bundle
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
            fatalError(" Resource \(resourceName) does not exist")
            // no big deal - just going to crash the preview
        }
        
        let data = try! Data(contentsOf: URL(filePath: path))
        // had to make T conform to Decodable in order to pass it to the JSONDecoder
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
