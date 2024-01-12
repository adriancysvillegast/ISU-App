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
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 80)

    /**
     this properties toEditTicket, ticketToEdit will hold some data to show a view to create ticket or to edit
     */
    
    var ticketToEdit: TicketModelCell?
    var toEditTicket: Bool = false
    
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
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Ticket".uppercased(), for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.isHidden = true
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateTicket), for: .touchUpInside)
        return button
    }()
    
    var location: PlacesModal?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         setUpView to set all properties on the view
         setUpViewForUpdates to show a create button or edit button
         */
        setUpViewForUpdates()
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
            labelDate, datePicker, createButton, editButton
        
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
            
            
            editButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
            editButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 210),
            editButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            
        ])
    }
    
    func setUpViewForUpdates() {
        guard let ticket = ticketToEdit, toEditTicket == true else {
            return
        }
        createButton.isHidden = true
        createButton.isEnabled = false
        editButton.isHidden = false
        editButton.isEnabled = true
        
        placeNameTextField.text = ticket.placeName
        clientTextField.text = ticket.name
        location = PlacesModal(
            name: ticket.placeName,
            cordinate: CoordinatePlaceModal(
                latitude: CLLocationDegrees(ticket.placeLatitude),
                longitude: CLLocationDegrees(ticket.placeLongitude))
        )
        datePicker.date = ticket.dateScheduled
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
    
    @objc func updateTicket() {
        guard let ticket = ticketToEdit else {
            return
        }
        viewModel.updateTicket(oldTicket: ticket, cliente: clientTextField.text, date: datePicker.date, location: location)
    }
    
    // MARK: - Methods

}
// MARK: - UITextFieldDelegate
extension NewTicketViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - NewTicketViewModelDelegate
extension NewTicketViewController: NewTicketViewModelDelegate {
//    modal to show success message and navigate to dashboard
    func wasAdded(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func errorAdding(message: String) {
        showAlertMessage(title: "Error", message: message)
    }
    
    func showAlert() {
        showAlertMessage(title: "Error", message: "You need to add all information, client nane, location and the day for this ticket")
    }
}

// MARK: - SearchLocationViewControllerDelegate

extension NewTicketViewController: SearchLocationViewControllerDelegate {
//    to save de location selected when you tap on a location
    func getLocation(location: PlacesModal) {
        DispatchQueue.main.async {
            self.location = location
            self.placeNameTextField.text = location.name
        }
    }
}





