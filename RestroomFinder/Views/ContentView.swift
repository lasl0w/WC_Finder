//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Mohammad Azam on 8/25/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    // good idea or bad idea.  Using it as an EO, makes it easy.  globally accessible and consistent.  
    //let restroomClient = RestroomClient()
    // allows us to get the values from the environment
    @Environment(\.httpClient) private var restroomClient
    
    // Create an instance of location manager
    @State private var locationManager = LocationManager.shared
    @State private var restrooms: [Restroom] = []
    // optional b/c it starts unselected, until the user selects one
    @State private var selectedRestroom: Restroom?
    
    
    // TODO: why async?
    private func loadRestrooms() async {
        // 1) get the region so we can ascertain the lat/long
        guard let region = locationManager.region else { return }
        let coordinate = region.center
        do {
            // retrieve from Constants file in Utilities group
            restrooms = try await restroomClient.fetchRestrooms(url: Constants.Urls.restroomsByLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        } catch {
            print(error.localizedDescription)
        }

    }
    
    var body: some View {
        ZStack {
            Map {
                ForEach(restrooms) { restroom in
                    //Marker(restroom.name, coordinate: restroom.coordinate)
                    Annotation(restroom.name, coordinate: restroom.coordinate) {
                        // use a trailing closure for content: property
                        Text("🚻")
                            .scaleEffect(selectedRestroom == restroom ? 2.0: 1.0)
                            .font(.title)
                            .onTapGesture {
                                withAnimation {
                                    selectedRestroom = restroom
                                }

                            }
                            .animation(.bouncy(duration: 0.25), value: selectedRestroom)
                    }
                }
                UserAnnotation()
            }
        }.task(id: locationManager.region) {
            // use the task modifier to load restrooms on
            // it takes time to get the user region, make it dependent on user region update
            await loadRestrooms()
            // restrooms is now populated
        }
    }
}

#Preview {
    ContentView()
    // replace with MockRestroomClient so we are not slamming against the API
        .environment(\.httpClient, MockRestroomClient())
    // load from the json file.  respect their server! (and prevent hitting API limits)
}
