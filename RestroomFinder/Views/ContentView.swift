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
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var position: MapCameraPosition = .userLocation(fallback: .apple)
    
    // TODO: why async?
    private func loadRestrooms() async {
        // 1) get the region so we can ascertain the lat/long
        //guard let region = locationManager.region else { return }
        // switch from user's region to visibleRegion so we can load restrooms based on map movement
        guard let region = visibleRegion else { return }
        // TODO: if visibleRegion doesn't exist yet, what happens, then should we fall back to locationManager.region
        /// NO, well sort of, better approach is to set the visibleRegion to the user's region in the initial map load.  Done!
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
            // add $position binding so it keeps the map centered on our position.  position awareness
            Map(position: $position) {
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
            if let region = locationManager.region {
                visibleRegion = region
                // use the task modifier to load restrooms on
                // it takes time to get the user region, make it dependent on user region update
                await loadRestrooms()
                // restrooms is now populated
            }

        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        // when the selectedRestroom changes, show the sheet and these properties
        .sheet(item: $selectedRestroom, content: { restroom in
            RestroomDetailView(restroom: restroom)
                .presentationDetents([.fraction(0.25)])
        })
        .overlay(alignment: .topLeading) {
            Button {
                Task {
                    // TODO: side effect is that Task might continue on after you leave this view.  any better options? Task tut.
                    await loadRestrooms()
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.largeTitle)
                //use foregroundStyle primary & secondary so it's not semi-transparent.  primary = shapeStyle, secondary = background shapeStyle
                    .foregroundStyle(.white, .blue )
            }
        }
    }
}

#Preview {
    ContentView()
    // replace with MockRestroomClient so we are not slamming against the API
        .environment(\.httpClient, MockRestroomClient())
    // load from the json file.  respect their server! (and prevent hitting API limits)
}
