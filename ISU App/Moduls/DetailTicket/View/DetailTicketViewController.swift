//
//  DetailTicketViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 9/1/24.
//

import UIKit
import DropDown


class DetailTicketViewController: UIViewController {

    // MARK: - Properties
    var ticket: TicketModelCell?
    
    private lazy var menuBar: UIBarButtonItem =  {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal")?.withTintColor(.green),
            style: .plain,
            target: self,
            action: #selector(showMenu))
        return button
    }()
    
    private let menuDropDown: DropDown = {
       let menu = DropDown()
        menu.dataSource = ["Get Directions", "DashBoard"]
        return menu
    }()
    
    
    private lazy var aViewCustomAndDate: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var aViewCustom: UIView = {
        let aView = UIView()
//        aView.backgroundColor = .blue
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var customerLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Customer Info:"
//        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var customerValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
//        label.backgroundColor = .blue
        label.text = "Jessica Green"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberPhoneValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
//        label.backgroundColor = .blue
        label.text = "519 234 4567"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aViewDate: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()

    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Sheduled for:"
        label.textAlignment = .right
//        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.textAlignment = .right
//        label.backgroundColor = .blue
        label.numberOfLines = 2
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let aView = UIView()
//        aView.backgroundColor = .red
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var notesView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var locationView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var locationLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Location Address:"
//        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.numberOfLines = 4
        label.textAlignment = .left
//        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonInfo: UIButton = {
        let aView = UIButton()
        aView.backgroundColor = .systemGreen
        aView.setTitle("Get Directions", for: .normal)
        aView.titleLabel?.textColor = .white
        aView.sizeToFit()
        aView.layer.cornerRadius = 12
        aView.addTarget(self, action: #selector(goToMap), for: .touchUpInside)
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var notesLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Dispatch Note:"
//        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noteValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Swift is required for this test App\nIt is required the use of architecture and design patterns\nApplication needs to be optimized for tablets with 10 Inches, however it needs to be responsive in order to operate with other resolutions\nThe iOS application needs to work with a local SQL Lite database structure\nThe application needs to be able to demonstrate add, modify and delete records\nThe application code needs to be submitted with proper in code comments and documentation in English.\nFor the address location user story, we will be reviewing a proper google maps API integration\nSubmitted the project to ISU Corp, providing the code"
        label.numberOfLines = 30
        label.textAlignment = .left
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationIconImage: UIImageView = {
       let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.image = UIImage(systemName: "location")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var noteIconImage: UIImageView = {
       let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.image = UIImage(systemName: "note.text")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var phoneIconImage: UIImageView = {
       let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.image = UIImage(systemName: "phone")
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var reasonContainerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var reasonLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Reason for call:"
//        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reasonValue: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Swift is required for this test App\nIt is required the use of architecture and design patterns\nApplication needs to be optimized for tablets with 10 Inches, however it needs to be responsive in order to operate with other resolutions\nThe iOS application needs to work with a local SQL Lite database structure"
        label.numberOfLines = 30
        label.textAlignment = .left
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavigationBar()
        updateView()
    }
    
    
    // MARK: - setUpView
    
    private func setUpView() {
        view.backgroundColor = .systemGray

        [aViewCustom, aViewDate ].forEach {
            aViewCustomAndDate.addSubview($0)
        }
        
        [customerLabel, customerValue, phoneIconImage, numberPhoneValue].forEach {
            aViewCustom.addSubview($0)
        }
        
        [dateLabel, dateValue].forEach {
            aViewDate.addSubview($0)
        }
        
        [locationIconImage, locationLabel, locationValue, buttonInfo].forEach {
            locationView.addSubview($0)
        }
        [notesLabel, noteIconImage, noteValue].forEach {
            notesView.addSubview($0)
        }
        
        [notesView, locationView].forEach {
            containerView.addSubview($0)
        }
        
        [reasonLabel, reasonValue].forEach {
            reasonContainerView.addSubview($0)
        }
        
        [ aViewCustomAndDate, containerView, reasonContainerView].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            aViewCustomAndDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            aViewCustomAndDate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            aViewCustomAndDate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            aViewCustomAndDate.heightAnchor.constraint(equalToConstant: 90),
            
            containerView.topAnchor.constraint(equalTo: aViewCustomAndDate.bottomAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            reasonContainerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            reasonContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            reasonContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            reasonContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            
            aViewCustom.topAnchor.constraint(equalTo: aViewCustomAndDate.topAnchor, constant: 0),
            aViewCustom.leadingAnchor.constraint(equalTo: aViewCustomAndDate.leadingAnchor, constant: 0),
            aViewCustom.bottomAnchor.constraint(equalTo: aViewCustomAndDate.bottomAnchor, constant: 0),
            aViewCustom.trailingAnchor.constraint(equalTo: aViewCustomAndDate.centerXAnchor, constant: 0),
            
            customerLabel.topAnchor.constraint(equalTo: aViewCustom.topAnchor, constant: 0),
            customerLabel.leadingAnchor.constraint(equalTo: aViewCustom.leadingAnchor, constant: 10),
            customerLabel.widthAnchor.constraint(equalToConstant: 120),

            customerValue.topAnchor.constraint(equalTo: customerLabel.bottomAnchor, constant: 10),
            customerValue.leadingAnchor.constraint(equalTo: aViewCustom.leadingAnchor, constant: 10),
            customerValue.widthAnchor.constraint(equalToConstant: 120),
            
            phoneIconImage.topAnchor.constraint(equalTo: customerValue.bottomAnchor, constant: 10),
            phoneIconImage.leadingAnchor.constraint(equalTo: aViewCustom.leadingAnchor, constant: 5),
            
            numberPhoneValue.topAnchor.constraint(equalTo: customerValue.bottomAnchor, constant: 10),
            numberPhoneValue.leadingAnchor.constraint(equalTo: phoneIconImage.trailingAnchor, constant: 0),
            
            aViewDate.topAnchor.constraint(equalTo: aViewCustomAndDate.topAnchor, constant: 0),
            aViewDate.trailingAnchor.constraint(equalTo: aViewCustomAndDate.trailingAnchor, constant: 0),
            aViewDate.bottomAnchor.constraint(equalTo: aViewCustomAndDate.bottomAnchor, constant: 0),
            aViewDate.leadingAnchor.constraint(equalTo: aViewCustomAndDate.centerXAnchor, constant: 0),
            
            dateLabel.topAnchor.constraint(equalTo: aViewDate.topAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: aViewDate.leadingAnchor, constant: 0),
            dateLabel.trailingAnchor.constraint(equalTo: aViewDate.trailingAnchor, constant: -5),
            
            dateValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            dateValue.leadingAnchor.constraint(equalTo: aViewDate.leadingAnchor, constant: 0),
            dateValue.trailingAnchor.constraint(equalTo: aViewDate.trailingAnchor, constant: -5),
            
            locationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            locationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            locationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            locationView.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -2),
            

            locationIconImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 0),
            locationIconImage.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 0),
            locationIconImage.widthAnchor.constraint(equalToConstant: 25),

            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: locationIconImage.trailingAnchor, constant: 5),
            locationLabel.widthAnchor.constraint(equalToConstant: 150),
            
            locationValue.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            locationValue.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 5),
            locationValue.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: 0),
            locationValue.heightAnchor.constraint(equalToConstant: 20),

            buttonInfo.topAnchor.constraint(equalTo: locationValue.bottomAnchor, constant: 5),
            buttonInfo.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 10),
            buttonInfo.widthAnchor.constraint(equalToConstant: 120),

            notesView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            notesView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            notesView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            notesView.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 2),

            noteIconImage.topAnchor.constraint(equalTo: notesView.topAnchor, constant: 0),
            noteIconImage.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 5),
            noteIconImage.widthAnchor.constraint(equalToConstant: 25),

            notesLabel.topAnchor.constraint(equalTo: notesView.topAnchor, constant: 0),
            notesLabel.leadingAnchor.constraint(equalTo: noteIconImage.trailingAnchor, constant: 0),
            notesLabel.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: 0),
            
            noteValue.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 5),
            noteValue.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 5),
            noteValue.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: 5),
            noteValue.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: 0),
            
            reasonLabel.topAnchor.constraint(equalTo: reasonContainerView.topAnchor, constant: 0),
            reasonLabel.leadingAnchor.constraint(equalTo: reasonContainerView.leadingAnchor, constant: 5),
            reasonLabel.bottomAnchor.constraint(equalTo: reasonContainerView.bottomAnchor, constant: -5),
            reasonLabel.widthAnchor.constraint(equalToConstant: 110),
            
            reasonValue.topAnchor.constraint(equalTo: reasonContainerView.topAnchor, constant: 0),
            reasonValue.leadingAnchor.constraint(equalTo: reasonLabel.trailingAnchor, constant: 5),
            reasonValue.trailingAnchor.constraint(equalTo: reasonContainerView.trailingAnchor, constant: -5),
            reasonValue.bottomAnchor.constraint(equalTo: reasonContainerView.bottomAnchor, constant: -5)
            
            
            
            
        ])
    }
    
    private func setUpNavigationBar() {
    
        navigationItem.setRightBarButtonItems(
            [menuBar ],
            animated: true)
        menuDropDown.anchorView = menuBar

    }
    
    // MARK: - Targets
    
    @objc func showMenu() {
        menuDropDown.show()
        menuDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)")
            navigation(index: index)
        }
    }
    
    
    @objc func goToMap() {
//        mostrar mata con los datos del lugar
    }
    // MARK: - Methods
    

    func updateView() {
        guard let ticket = ticket else {
            return
        }
        
        let date = ticket.dateScheduled.formatted(date: .numeric, time: .standard)
        let dateArray = date.components(separatedBy: ", ")
        
        DispatchQueue.main.async {
            self.dateValue.text = "\(dateArray[0])\n\(dateArray[1])"
            self.locationValue.text = ticket.placeName
        }
    }
    func navigation(index: Int) {
        if index == 0 {
//            go to show the direction of the ticket
        }else {
            navigationController?.dismiss(animated: true)
        }
    }

}
