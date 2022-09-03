//
//  AuthorizationViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 21.08.2022.
//

import UIKit

class AuthorizationViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buttonTextSize: CGFloat = 16
        static let insets: CGFloat = 16
        static let loginTopInset: CGFloat = 30
        static let viewHeight: CGFloat = 56
        static let errorViewHeight: CGFloat = 56
        static let bigInset: CGFloat = 32
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - Properties
    
    private var loginHeightConstraint = NSLayoutConstraint()
    private var passwordHeightConstraint = NSLayoutConstraint()
    
    // MARK: - Sublayers
    
    private lazy var loginView: AuthorizationFieldView = {
        $0.mode = .login
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (AuthorizationFieldView(frame: CGRect(x: 0, y: 0, width: view.frame.width - Constants.bigInset, height: Constants.viewHeight - 1)))
    
    private lazy var passwordView: AuthorizationFieldView = {
        $0.mode = .password
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (AuthorizationFieldView(frame: CGRect(x: 0, y: 0, width: view.frame.width - Constants.bigInset, height: Constants.viewHeight - 1)))
    
    private lazy var button: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont(name: "SFProText-Regular", size: Constants.buttonTextSize)
        $0.backgroundColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return $0
    } (UIButton())
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        placeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Вход"
    }
}

// MARK: - Actions

private extension AuthorizationViewController {
    
    @objc
    private func loginAction() {
        loginView.textField.resignFirstResponder()
        passwordView.textField.resignFirstResponder()
        loginView.isError = loginView.textField.text?.count != 18
        passwordView.isError = passwordView.textField.text?.isEmpty ?? true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        if !loginView.isError, !passwordView.isError {
            print("all right")
        }
    }
}

// MARK: - Sublayers Placement

private extension AuthorizationViewController {
    
    func placeSubviews() {
        placeLoginTextField()
        placePasswordTextField()
        placeButton()
    }
    
    func placeLoginTextField() {
        view.addSubview(loginView)
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insets).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.insets).isActive = true
        loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.loginTopInset).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: Constants.viewHeight).isActive = true
    }
    
    func placePasswordTextField() {
        view.addSubview(passwordView)
        passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insets).isActive = true
        passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.insets).isActive = true
        passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: Constants.insets).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: Constants.viewHeight).isActive = true
    }
    
    func placeButton() {
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insets).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.insets).isActive = true
        button.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: Constants.bigInset).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
    }
}
