//
//  MockRestroomClient.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/19/23.
//

import Foundation

struct MockRestroomClient: HTTPClient {
    
    
    // create the 'restrooms.json' file
    
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        
        
        return PreviewData.load(resourceName: "restrooms")
    }
    
    
    
}
