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
        static let errorViewHeight: CGFloat = 80
        static let bigInset: CGFloat = 32
        static let buttonHeight: CGFloat = 48
        static let animationDuration: CGFloat = 0.3
        static let phoneNumberCount = 18
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
    
    private lazy var button: LoaderButton = {
        $0.setTitle("Войти", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont(name: "SFProText-Regular", size: Constants.buttonTextSize)
        $0.backgroundColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return $0
    } (LoaderButton())
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        placeSubviews()
        handleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Вход"
    }
}

// MARK: - Actions

private extension AuthorizationViewController {
    
    @objc
    func loginAction() {
        loginView.textField.resignFirstResponder()
        passwordView.textField.resignFirstResponder()
        loginView.isError = loginView.textField.text?.count != Constants.phoneNumberCount
        passwordView.isError = passwordView.textField.text?.isEmpty ?? true
        updateViewsHeight()
        if !loginView.isError, !passwordView.isError {
            authorizate()
        }
    }
}

// MARK: - Networking

private extension AuthorizationViewController {
    
    func authorizate() {
        button.startLoader()
        let crendentials = AuthRequestModel(phone: loginView.textField.textPhone(),
                                            password: passwordView.textField.text ?? "")
        AuthService().performLoginRequestAndSaveToken(credentials: crendentials) { [weak self] result in
            guard let self = self else { return }
            self.button.stopLoader()
            switch result {
            case let .failure(error):
                print(error)
            case .success:
                guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
                    return
                }

                let root = TabBarConfigurator().configure()

                UIView.transition(with: window,
                                  duration: 0.0,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      window.rootViewController = root
                                  })
            }
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
        loginView.heightAnchor.constraint(equalToConstant: Constants.errorViewHeight).isActive = true
        loginHeightConstraint = loginView.heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        loginHeightConstraint.isActive = true
    }
    
    func placePasswordTextField() {
        view.addSubview(passwordView)
        passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insets).isActive = true
        passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.insets).isActive = true
        passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: Constants.insets).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: Constants.errorViewHeight).isActive = true
        passwordHeightConstraint = passwordView.heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        passwordHeightConstraint.isActive = true
    }
    
    func placeButton() {
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.insets).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.insets).isActive = true
        button.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: Constants.bigInset).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
    }
}

// MARK: - View Utilts

private extension AuthorizationViewController {
     
    func updateViewsHeight() {
        passwordHeightConstraint.isActive = !passwordView.isError
        loginHeightConstraint.isActive = !loginView.isError
        UIView.animate(withDuration: Constants.animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func handleViews() {
        loginView.changeState = { [weak self] in
            guard let self = self else { return }
            self.updateViewsHeight()
        }
        passwordView.changeState = { [weak self] in
            guard let self = self else { return }
            self.updateViewsHeight()
        }
    }
}
