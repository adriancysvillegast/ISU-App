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
    let menuDropDown: DropDown = {
       let menu = DropDown()
        menu.dataSource = ["Work Ticket", "Get Directions"]
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
        
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpNavigationBar()
        setUpView()
        
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
        
    }
    
    @objc func syncEmail() {
        
    }
    
    @objc func addNewTicket() {
        
    }
    
    @objc func showMenu() {
        menuDropDown.show()
    }
    
    // MARK: - Methods

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
