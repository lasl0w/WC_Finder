//
//  RestroomDetailView.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/21/23.
//

import SwiftUI

// TODO: how does a preview work when you have multiple structs?
struct AmenitiesView: View {
    
    let restroom: Restroom
    
    var body: some View {
        // space 12 between each amenity icon
        HStack(spacing: 12) {
            AmenityView(symbol: "♿", isEnabled: restroom.accessible)
            AmenityView(symbol: "🚻", isEnabled: restroom.unisex)
            AmenityView(symbol: "🚼", isEnabled: restroom.changingTable)
        }
    }
}

struct AmenityView: View {
    
    let symbol: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            Text(symbol)
        }
    }
}



struct RestroomDetailView: View {
    
    // must pass in the restroom in order to show the detail
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restroom.name)
                .font(.title3)
            Text(restroom.address)
            if let comment = restroom.comment {
                Text(comment)
                    .font(.caption)
            }
            AmenitiesView(restroom: restroom)
            ActionButtons(mapItem: restroom.mapItem)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

#Preview {
    let restrooms: [Restroom] = PreviewData.load(resourceName: "restrooms")
    // TODO: must change to return statement.  but why?
    return RestroomDetailView(restroom:  restrooms.first!)
}
