//
//  ActionButtons.swift
//  NearMe
//
//  Created by Mohammad Azam on 8/21/23.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            
            Button(action: {
                MKMapItem.openMaps(with: [mapItem])
            }, label: {
                HStack {
                    HStack {
                        Image(systemName: "car.circle.fill")
                        Text("Take me there")
                    }
                }
            }).buttonStyle(.bordered)
                .tint(.green)
            
            Spacer()
            
        }
    }
}

