//
//  HTTPClientKey.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/17/23.
//

import Foundation
import SwiftUI

private struct HTTPClientKey: EnvironmentKey {
    
    // needs to have a default to conform
    static var defaultValue = RestroomClient()
    
    // future - create a fake one that just reads a static json file instead of calling the api
}

extension EnvironmentValues {
    
    // concrete base implementation - just returning the default
    var httpClient: RestroomClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}
