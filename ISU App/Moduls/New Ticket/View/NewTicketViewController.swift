//
//  NewTicketViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 7/1/24.
//

import UIKit
import GoogleMaps



class NewTicketViewController: UIViewController {
    // MARK: - Properties
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 90)

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var viewModel: NewTicketViewModel = {
        let viewModel = NewTicketViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    
    //    let locationManager =  CLLocationManager()
    //    var currentLocation: CLLocation?
    //    var mapView: GMSMapView!
    //    var selectedPlace: CLLocationCoordinate2D?//esto lo modifique
    
    private lazy var labelClient: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.text = "Client Name"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clientTextField: UITextField = {
        let aTextField = UITextField()
        let sepationView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        aTextField.leftViewMode = .always
        aTextField.leftView = sepationView
        aTextField.textContentType = .name
        aTextField.placeholder = "Client Name".capitalized
        aTextField.borderStyle = .roundedRect
        aTextField.tintColor = .secondaryLabel
        aTextField.layer.cornerRadius = 12
        aTextField.translatesAutoresizingMaskIntoConstraints = false
        aTextField.delegate = self
        return aTextField
    }()
    
    
    private lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.text = "Address".capitalized
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var placeNameTextField: UITextField = {
        let aTextField = UITextField()
        let sepationView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        aTextField.leftViewMode = .always
        aTextField.leftView = sepationView
        aTextField.isEnabled = false
        aTextField.textContentType = .addressCity
        aTextField.placeholder = "City name".capitalized
        aTextField.borderStyle = .roundedRect
        aTextField.tintColor = .secondaryLabel
        aTextField.layer.cornerRadius = 12
        aTextField.translatesAutoresizingMaskIntoConstraints = false
//                aTextField.addTarget(self, action: #selector(validateInfo), for: .editingChanged)
        aTextField.delegate = self
        return aTextField
    }()
    
    lazy var countryNameTextField: UITextField = {
        let aTextField = UITextField()
        let sepationView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        aTextField.leftViewMode = .always
        aTextField.leftView = sepationView
        aTextField.textContentType = .countryName
        aTextField.placeholder = "Country name".capitalized
        aTextField.borderStyle = .roundedRect
        aTextField.tintColor = .secondarySystemBackground
        aTextField.layer.cornerRadius = 12
        aTextField.translatesAutoresizingMaskIntoConstraints = false
        //        aTextField.addTarget(self, action: #selector(emailValidate), for: .editingChanged)
        aTextField.delegate = self
        return aTextField
    }()
    
    private lazy var goToSearchLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Location".uppercased(), for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.isEnabled = true
        button.titleLabel?.textColor = .label
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.text = "Date".capitalized
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .automatic
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add ticket".uppercased(), for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 12
        button.isEnabled = true
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createTicket), for: .touchUpInside)
        return button
    }()
    
    var location: PlacesModal?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        GMSServices.provideAPIKey(viewModel.api_key)
        //        showAlertMessage(title: "License Info", message: GMSServices.openSourceLicenseInfo())
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
        
        setUpView()
    }
    
    // MARK: - setUpView
    private func setUpView() {
        view.backgroundColor = .white
        title = "Add a new ticket"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [
            labelClient,clientTextField, labelAddress, placeNameTextField, goToSearchLocationButton,
//            cityNameTextField, countryNameTextField,
            labelDate, datePicker, createButton
        
        ].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            labelClient.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            labelClient.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            labelClient.widthAnchor.constraint(equalToConstant: 100),
            
            clientTextField.topAnchor.constraint(equalTo: labelClient.bottomAnchor, constant: 5),
            clientTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            clientTextField.widthAnchor.constraint(equalToConstant: containerView.frame.width/1.2),
            
            labelAddress.topAnchor.constraint(equalTo: clientTextField.bottomAnchor, constant: 8),
            labelAddress.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            labelAddress.widthAnchor.constraint(equalToConstant: 100),
            
            placeNameTextField.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 5),
            placeNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            placeNameTextField.widthAnchor.constraint(equalToConstant: containerView.frame.width/1.2),
            
            
            goToSearchLocationButton.topAnchor.constraint(equalTo: placeNameTextField.bottomAnchor, constant: 8),
            goToSearchLocationButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            goToSearchLocationButton.widthAnchor.constraint(equalToConstant: containerView.frame.width/2),
//            cityNameTextField.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 5),
//            cityNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            cityNameTextField.widthAnchor.constraint(equalToConstant: containerView.frame.width/1.2),
//
//            countryNameTextField.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 5),
//            countryNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            countryNameTextField.widthAnchor.constraint(equalToConstant: containerView.frame.width/1.2),
//
            labelDate.topAnchor.constraint(equalTo: goToSearchLocationButton.bottomAnchor, constant: 8),
            labelDate.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            labelDate.widthAnchor.constraint(equalToConstant: 100),
            
            datePicker.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 5),
            datePicker.heightAnchor.constraint(equalToConstant: 60),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            createButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
            createButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 200),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
    
    // MARK: - targets
    @objc func createTicket() {
        viewModel.createNewTicket(cliente: clientTextField.text, date: datePicker.date, location: location)
    }
    
    @objc func goToMap() {
        let vc = SearchLocationViewController()
        vc.delegate = self
        vc.title = "Map"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func validateInfo() {
        viewModel.reviewInfo(cliente: clientTextField.text, date: datePicker.date, location: location)
    }
    // MARK: - Methods

}
extension NewTicketViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == clientTextField || textField == placeNameTextField{
            scrollView.frame.origin.y -= 40
        }else if textField == countryNameTextField {
            scrollView.frame.origin.y -= 120
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.frame.origin.y = 0
    }
    
}
// MARK: - NewTicketViewModelDelegate
extension NewTicketViewController: NewTicketViewModelDelegate {
    func wasAdded() {
//        showAlertAndDismiss(title: "Success", message: "The ticket was Added")
        
        let alert = UIAlertController(title: "Success", message: "The ticket was Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func errorAdding() {
        showAlertMessage(title: "Error", message: "Try again")
    }
    
    func showAlert() {
        showAlertMessage(title: "Error", message: "You need to add all information, client nane, location and the day for this ticket")
    }
}

// MARK: - SearchLocationViewControllerDelegate

extension NewTicketViewController: SearchLocationViewControllerDelegate {
    func getLocation(location: PlacesModal) {
        DispatchQueue.main.async {
            self.location = location
            self.placeNameTextField.text = location.name
        }
    }
    
    
}



//extension NewTicketViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        print(locations)
//        let cordinate = location.coordinate
//        let camera = GMSCameraPosition.camera(withLatitude:cordinate.latitude, longitude: cordinate.longitude, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//        self.view.addSubview(mapView)
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: cordinate.latitude, longitude: cordinate.longitude)
//        marker.title = "saa"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//
//    }
//}
