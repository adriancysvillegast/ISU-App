//
//  SearchLocationViewModel.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import Foundation
import GooglePlaces
import MapKit


class SearchLocationViewModel {
    
    // MARK: - Properties
    
    private var googlePlacesManager: GooglePlacesManager
    
    init(googlePlacesManager: GooglePlacesManager = GooglePlacesManager()) {
        self.googlePlacesManager = googlePlacesManager
    }
    
    // MARK: - Methods
    
    func getLocation(query: String, mapKitView: MKMapView , completion: @escaping ([PlacesModal]) -> Void ) {
        
        /*The code inside was working like a charm but how i don't have an account for billing
         it stopped giving me locations.
         
         being honest i don't have a credic card to add on google cloud, i tried with my zinli card but it didn't allow me
         
        googlePlacesManager.findPlaces(query: query) { result in
            switch result {
            case .success(let success):
                let places = success.compactMap {
                    PlacesModal(name: $0.attributedFullText.string, id: $0.placeID)
                }
                
                completion(places)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
         */
        
        //Using MapKit I can get some recomendation or sugestion by name
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapKitView.region
        let result = MKLocalSearch(request: request)
        result.start { result, error in
            
            guard let result = result, error == nil else {
                print(error?.localizedDescription)
                return
            }
            let resultValues = result.mapItems.compactMap({
                PlacesModal(name: $0.name ?? "With out name", cordinate: CoordinatePlaceModal(latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude))
            })
            completion(resultValues)
        }
        
    }
    
    deinit {
        print("\(#function) without memory leak")
    }
    
}
