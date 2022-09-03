//
//  AuthorizationFieldView.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 24.08.2022.
//

import UIKit

enum TextFieldMode {
    case login
    case password
    
    var placeholderText: String {
        switch self {
        case .login:
            return "Логин"
        case .password:
            return "Пароль"
        }
    }
}

class AuthorizationFieldView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let buttonTextSize: CGFloat = 16
        static let labelTextSize: CGFloat = 12
        static let textFieldRadius: CGFloat = 10
        static let insets: CGFloat = 16
        static let loginTopInset: CGFloat = 30
        static let textFieldHeight: CGFloat = 56
        static let bigInset: CGFloat = 32
        static let alpha: CGFloat = 0.5
    }

    // MARK: - Properties
    
    //Private
    private var labelConstraint = NSLayoutConstraint()
    
    // Public
    public var isError = false {
        didSet {
            labelConstraint.isActive = !isError
        }
    }
    public var mode: TextFieldMode? {
        didSet {
            configureSubviews()
        }
    }

    // MARK: - Subviews

    public lazy var textField: PaddingTextField = {
        $0.backgroundColor = .systemGroupedBackground.withAlphaComponent(Constants.alpha)
        $0.tintColor = .black
        $0.addCorners(type: .top, radius: Constants.textFieldRadius)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (PaddingTextField(frame: frame))
    
    private lazy var errorLabel: UILabel = {
        $0.textColor = .red
        $0.text = "Поле не может быть пустым"
        $0.font = UIFont(name: "SFProText-Regular", size: Constants.labelTextSize)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UILabel())

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        placeSubviews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init has not been implemented")
    }
}

// MARK: - Setup subviews

private extension AuthorizationFieldView {
    
    func configureSubviews() {
        textField.delegate = self
        guard let mode = mode else { return }
        switch mode {
        case .login:
            textField.placeholder = "Логин"
            textField.keyboardType = .decimalPad
        case .password:
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
            textField.clearButtonMode = .whileEditing
        }
    }
    
    func placeSubviews() {
        placeLoginTextField()
        placeLabel()
    }
    
    func placeLoginTextField() {
        addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
        textField.addSeparator()
    }
    
    func placeLabel() {
        addSubview(errorLabel)
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.insets).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.insets).isActive = true
        errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        labelConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        labelConstraint.isActive = true
    }
}

// MARK: - UITextFieldDelegate

extension AuthorizationFieldView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        if text.isEmpty, mode == .login {
            textField.text = "+7 ("
        }
        isError = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
        mode != .password else { return }
        if text == "+7 (" {
            textField.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
                mode != .password else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = textField.phoneFormat(phone: newString)
        return false
    }
}
