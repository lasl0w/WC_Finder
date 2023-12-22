//
//  RestroomClient.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/16/23.
//

import Foundation

// make it conform to HTTPClient so we can get restrooms from a local JSON file during dev
struct RestroomClient: HTTPClient {
    
    // API responses can of course throw errors, so implement that first
    private enum RestroomClientError: Error {
        case invalidResponse
        // TODO: why do we pass in the error here, but not on invalidResponse
        case networkError(Error)
    }
    
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        
        // TODO:  URLSession tut, JSONDecoder tut
        let (data, response) = try await URLSession.shared.data(from: url)
        print(url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            print("response is not 200")
            throw RestroomClientError.invalidResponse
        }
        
        // This works too if we want to look at the full stack to troubleshoot.  It will throw the system error by default
        //return try JSONDecoder().decode([Restroom].self, from: data)
        
        do {
            return try JSONDecoder().decode([Restroom].self, from: data)
        } catch {
            print(error.localizedDescription)
            throw RestroomClientError.networkError(error)
            
        }
        
        //return []
    }
}
