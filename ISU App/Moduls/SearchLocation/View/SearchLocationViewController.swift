//
//  SearchLocationViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import UIKit
import MapKit
import CoreLocation

protocol SearchLocationViewControllerDelegate: AnyObject {
    func getLocation(location: PlacesModal)
}

class SearchLocationViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: SearchLocationViewControllerDelegate?

    var fromHome: Bool = false
    
    private var placeSelected: PlacesModal?
    
    private lazy var viewModel: SearchLocationViewModel = {
        let viewModel = SearchLocationViewModel()
        return viewModel
    }()
    
    private lazy var mapKitView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private let searchVC = UISearchController(searchResultsController: SearchResultViewController())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.searchResultsUpdater = self
        
       setUpView()
        hiddenSaveButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapKitView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.width,
            height: view.frame.height - view.safeAreaInsets.top)
    }
    
    // MARK: - SetUpView
    private func setUpView() {
        view.addSubview(mapKitView)
        navigationItem.searchController = searchVC
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveLocation))
        navigationItem.rightBarButtonItem?.isEnabled = false
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
    }
    
    
    @objc func saveLocation() {
        guard let place = placeSelected else {
            return
        }
        delegate?.getLocation(location: place)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    func hiddenSaveButton() {
        if fromHome{
            navigationItem.rightBarButtonItem?.isHidden = true
        }
    }
}


// MARK: - UISearchResultsUpdating

extension SearchLocationViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let query  = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty, let resultsVC = searchController.searchResultsController as? SearchResultViewController else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        resultsVC.delegate = self
        
        viewModel.getLocation(query: query, mapKitView: mapKitView) { result in
            resultsVC.updateTable(placesResult: result)
        }
        

        /*
         The code inside was working like a charm but how i don't have an account for billing
         it stopped giving me locations.
         
         being honest i don't have a credic card to add on google cloud, i tried with my zinli card but it didn't allow me
         
         viewModel.getLocation(query: query) { places in
             DispatchQueue.main.async {
                 resultsVC.updateTable(placesResult: places)
             }
         }
         */
    }
    
    
    
}

// MARK: - SearchResultViewControllerDelegate
extension SearchLocationViewController: SearchResultViewControllerDelegate {
    func didTapLocation(place: PlacesModal) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true)
        
        placeSelected = place
        let anotations = mapKitView.annotations
        mapKitView.removeAnnotations(anotations)
        
        let pin = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: place.cordinate.latitude, longitude: place.cordinate.longitude)
        pin.coordinate = coordinate
        mapKitView.addAnnotation(pin)
        mapKitView.setRegion(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2)),
            animated: true
        )
    }
}
