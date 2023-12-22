//
//  HTTPClient.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/19/23.
//

import Foundation

// create this in order to stub out or mock serving the data so we don't call the API all the time when we are developing and testing out the UI
protocol HTTPClient {
    // stub out the function
    func fetchRestrooms(url: URL) async throws -> [Restroom]
}
