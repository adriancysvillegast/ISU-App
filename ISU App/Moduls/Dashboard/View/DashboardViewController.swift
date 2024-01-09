//
//  DashboardViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 5/1/24.
//

import UIKit
import DropDown


class DashboardViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var viewModel: DashBoardViewModel = {
        let viewModel = DashBoardViewModel()
        return viewModel
    }()
    
    private let menuDropDown: DropDown = {
       let menu = DropDown()
        menu.dataSource = ["Work Ticket", "Get Directions", "Log Out"]
        
        return menu
    }()
    
    private lazy var menuBar: UIBarButtonItem =  {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal")?.withTintColor(.green),
            style: .plain,
            target: self,
            action: #selector(showMenu))
        return button
    }()
    
    private lazy var aTableView: UITableView = {
        let aTableView = UITableView()
        aTableView.register(TicketTableViewCell.self, forCellReuseIdentifier: TicketTableViewCell.identifier)
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.backgroundColor = .systemGray
        aTableView.separatorStyle = .singleLine
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        return aTableView
    }()
    
//    private let scopes = [kGTLRAuthScopeCalendar]
//    private let service = GTLRCalendarService()
//    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        setUpNavigationBar()
        setUpView()
        viewModel.conectToDB()
        
        
//        GIDSignIn.sharedInstance.clientID = "your-key-goes-here"
//        GIDSignIn.sharedInstance
//        GIDSignIn.sharedInstance().scopes = scopes
//        GIDSignIn.sharedInstance.presentingViewController = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTickets()
    }
    
    // MARK: - SetupView
    private func setUpNavigationBar() {
        navigationItem.setLeftBarButtonItems(
            [
                UIBarButtonItem(
                    image: UIImage(systemName: "calendar")?.withTintColor(.green),
                    style: .plain,
                    target: self,
                    action: #selector(goToCalendar)),
            UIBarButtonItem(
                image: UIImage(systemName: "arrow.2.squarepath")?.withTintColor(.green),
                style: .plain,
                target: self,
                action: #selector(syncEmail))
            ],
            animated: true)
        
    
        navigationItem.setRightBarButtonItems(
            [
            menuBar,
            UIBarButtonItem(
                image: UIImage(systemName: "plus")?.withTintColor(.green),
                style: .plain,
                target: self,
                action: #selector(addNewTicket))
            ],
            animated: true)
        
        menuDropDown.anchorView = menuBar
        
    }
    
    private func setUpView() {
        view.addSubview(aTableView)
        
        NSLayoutConstraint.activate([
            aTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            aTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            aTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            aTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func getTickets() {
        viewModel.getTickets()
        aTableView.reloadData()
        
//        viewModel.showData { [weak self] tickets in
//            DispatchQueue.main.async {
//                self?.tickets = tickets
//                self?.aTableView.reloadData()
//            }
//        }
    }
    
    // MARK: - Targets
    
    @objc func goToCalendar () {
        viewModel.logOut()
    }
    
    @objc func syncEmail() {
        signUpGoogle()
    }
    
    @objc func addNewTicket() {
        let vc = NewTicketViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showMenu() {
        menuDropDown.show()
        
    }
    
    // MARK: - Methods

    func signUpGoogle() {
        
        if viewModel.isSignedIn {
//            show alert
            showAlertMessage(title: "You're logged", message: "\(viewModel.name ?? "Someone") is conected ")
        } else {
            
            viewModel.logInGoogle(vc: self)
        }
        
        
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTicketsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketTableViewCell.identifier, for: indexPath) as? TicketTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(ticket: viewModel.ticketForRowAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ticketSelected = viewModel.ticketForRowAt(index: indexPath.row)
        let vc = DetailTicketViewController()
        vc.ticket = ticketSelected
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
