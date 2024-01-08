//
//  SearchResultViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import UIKit
import CoreLocation
import MapKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func didTapLocation(place: PlacesModal)
}

class SearchResultViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: SearchResultViewControllerDelegate?
    
    private var places: [PlacesModal] = []
    
    private lazy var viewModel: SearchLocationViewModel = {
        let viewModel = SearchLocationViewModel()
        return viewModel
    }()
    
    private lazy var aTableView: UITableView = {
        let aTable =  UITableView()
        aTable.backgroundColor = .clear
        aTable.delegate = self
        aTable.dataSource = self
        aTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return aTable
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aTableView.frame = view.bounds
    }
    
    private func setUpView() {
        view.backgroundColor = .clear
        view.addSubview(aTableView)
    }
    
    
    // MARK: - Methods
    
    func updateTable(placesResult: [PlacesModal]) {
        self.aTableView.isHidden = false
        places = placesResult
        aTableView.reloadData()
    }
}


// MARK: - SearchResultViewController

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async {
            self.delegate?.didTapLocation(place: self.places[indexPath.row])
        }
        
        tableView.isHidden = true
        
    }
    
}
