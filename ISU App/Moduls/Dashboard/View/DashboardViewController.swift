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
    
//    private let scopes = [kGTLRAuthScopeCalendar]
//    private let service = GTLRCalendarService()
//    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpNavigationBar()
        setUpView()
        
//        GIDSignIn.sharedInstance.clientID = "your-key-goes-here"
//        GIDSignIn.sharedInstance
//        GIDSignIn.sharedInstance().scopes = scopes
//        GIDSignIn.sharedInstance.presentingViewController = self
        // Do any additional setup after loading the view.
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
