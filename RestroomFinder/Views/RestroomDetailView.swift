//
//  RestroomDetailView.swift
//  RestroomFinder
//
//  Created by tom montgomery on 12/21/23.
//

import SwiftUI

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
        }
    }
}

#Preview {
    let restrooms: [Restroom] = PreviewData.load(resourceName: "restrooms")
    // TODO: must change to return statement.  but why?
    return RestroomDetailView(restroom:  restrooms.first!)
}
