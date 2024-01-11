//
//  LogInViewController.swift
//  ISU App
//
//  Created by Adriancys Jesus Villegas Toro on 5/1/24.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    /**
     I'm going to use lazy var to make better the performance or processing time.
    **/
    private lazy var viewModel: LogInViewModel = {
        let viewModel = LogInViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private var logoView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints =  false
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let aTextField = UITextField()
        let imageView =  UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        let image = UIImage(systemName: "person")
        imageView.image = image
        let sepationView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        imageView.contentMode = .scaleAspectFit
        sepationView.addSubview(imageView)
        aTextField.leftViewMode = .always
        aTextField.leftView = sepationView
        aTextField.textContentType = .emailAddress
        aTextField.placeholder = "Email".uppercased()
        aTextField.borderStyle = .roundedRect
        aTextField.tintColor = .secondaryLabel
        aTextField.text = "adriancysvillegast@gmail.com"
        aTextField.layer.borderColor = UIColor.green.cgColor
        aTextField.layer.borderWidth = 0.7
        aTextField.layer.cornerRadius = 12
        aTextField.translatesAutoresizingMaskIntoConstraints = false
        aTextField.addTarget(self, action: #selector(emailValidate), for: .editingChanged)
        aTextField.delegate = self
        return aTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let aTextField = UITextField()
        let imageView =  UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        
        let image = UIImage(systemName: "lock")
        imageView.image = image
        let sepationView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        imageView.contentMode = .scaleAspectFit
        sepationView.addSubview(imageView)
        aTextField.leftViewMode = .always
        aTextField.leftView = sepationView
        aTextField.textContentType = .password
        aTextField.placeholder = "Password".uppercased()
        aTextField.borderStyle = .roundedRect
        aTextField.tintColor = .secondaryLabel
        aTextField.layer.borderColor = UIColor.green.cgColor
        aTextField.layer.borderWidth = 0.7
        aTextField.text = "123456789A"
        aTextField.layer.cornerRadius = 12
        aTextField.translatesAutoresizingMaskIntoConstraints = false
        aTextField.addTarget(self, action: #selector(passwordValidate), for: .editingChanged)
        aTextField.delegate = self
        return aTextField
    }()
    
    private lazy var logIn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In".uppercased(), for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        return button
    }()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        [logoView, emailTextField, passwordTextField, logIn].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 230),
            logoView.heightAnchor.constraint(equalToConstant: 80),
            
            emailTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 230),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 230),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logIn.widthAnchor.constraint(equalToConstant: 230),
            logIn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    // MARK: - Targets
    
    @objc func logInButton () {
        viewModel.logIn(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func emailValidate() {
        viewModel.validateEmail(emailUser: emailTextField.text)
    }
    
    @objc func passwordValidate() {
        viewModel.validatePassword(password: passwordTextField.text)
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController : UITextFieldDelegate {
    
    
}

// MARK: - LogInViewModelDelegate
extension LogInViewController: LogInViewModelDelegate {
    func goToDashBoard() {
        let vc = DashboardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let alert = UIAlertController(title: "error".uppercased(), message: "we got an error when trying to log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    func inactiveButton() {
        DispatchQueue.main.async {
            self.logIn.isEnabled = false
            self.logIn.backgroundColor = .gray
        }
    }
    
    func activateButton() {
        DispatchQueue.main.async {
            self.logIn.isEnabled = true
            self.logIn.backgroundColor = .green
        }
    }
    
    
}

