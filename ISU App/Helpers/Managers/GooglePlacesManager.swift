//
//  GooglePlacesManager.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import Foundation
import GooglePlaces

final class GooglePlacesManager {
    // MARK: - Properties
    
    private let client = GMSPlacesClient.shared()
    
    enum PlacesError: Error {
    case failedToFindPlaces
    }
    
    // MARK: - Methods
    
    func findPlaces(
        query: String,
        completion: @escaping (Result<[GMSAutocompletePrediction], Error>) -> Void
    ) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
//        filter.types = ["Address"]
        client.findAutocompletePredictions(
            fromQuery: query, filter: filter, sessionToken: nil) { result, error in
                
                
                guard let result = result, error == nil else {
                    print(error?.localizedDescription)
                    completion(.failure(PlacesError.failedToFindPlaces))
                    return
                }
                
                completion(.success(result))
            }
    }
}
