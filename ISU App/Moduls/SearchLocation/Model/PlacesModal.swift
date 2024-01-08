//
//  PlacesModal.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import Foundation
import CoreLocation

struct PlacesModal {
    let name: String
    let cordinate: CoordinatePlaceModal
}

struct CoordinatePlaceModal {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
