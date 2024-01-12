//
//  HomeTabBar.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 11/1/24.
//

import UIKit

class HomeTabBar: UITabBarController {
    // MARK: - Properties
    private let ticket: TicketModelCell
    
    // MARK: - init
    init(ticket: TicketModelCell) {
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        navigationController?.navigationBar.backgroundColor = .systemGray
    }
    

    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?, nameItem: String) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = nameItem
        navController.tabBarItem.titlePositionAdjustment.vertical = CGFloat(-20)
        navController.navigationBar.tintColor = .label
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }

    func setupVCs() {
            viewControllers = [
                createNavController(for: DetailTicketViewController(ticket: ticket), title: NSLocalizedString("Work Item", comment: ""), image: UIImage(systemName: ""), nameItem: "Overview"),
                createNavController(for: Controller1(), title: NSLocalizedString("Work Details", comment: ""), image: UIImage(systemName: ""), nameItem: "Work Details"),
                createNavController(for: Controller1(), title: NSLocalizedString("Purchasing", comment: ""), image: UIImage(systemName: ""), nameItem: "Purchasing"),
                createNavController(for: Controller1(), title: NSLocalizedString("Finisging Up", comment: ""), image: UIImage(systemName: ""), nameItem: "Finisging Up"),
                createNavController(for: Controller1(), title: NSLocalizedString("", comment: ""), image: UIImage(systemName: "camera"), nameItem: "")
                
                
            ]
        }

}
