//
//  LocationTicketViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 11/1/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class LocationTicketViewController: UIViewController {
    
    
    // MARK: - Properties

    private lazy var mapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    var ticket: TicketModelCell?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey(Constants.api_key)
        showAlertMessage(title: "License Info", message: GMSServices.openSourceLicenseInfo())
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    func setUpView() {
        guard let ticket = ticket else {
            return
        }
        
        let camera = GMSCameraPosition.camera(
            withLatitude: ticket.placeLatitude,
            longitude: ticket.placeLongitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: ticket.placeLatitude, longitude: ticket.placeLongitude)
        marker.title = ticket.placeName
        marker.map = mapView
        view.addSubview(mapView)
    }
}
