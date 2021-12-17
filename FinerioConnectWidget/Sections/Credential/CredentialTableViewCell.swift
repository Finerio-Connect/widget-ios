//
//  CredentialTableViewCell.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 17/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialTableViewCell: UITableViewCell {
    // Components
    lazy var titleLabel: UILabel = setupTitleLabel()
    lazy var inputTexfield: PaddedTextField = setupPaddedTextField()
    
    // Vars
    static let id = "CredentialTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Data
extension CredentialTableViewCell {
    func setup(with field: BankField) {
        titleLabel.text = field.friendlyName
        inputTexfield.placeholder = field.friendlyName
        inputTexfield.id = field.name
        
        if field.name.uppercased() == Constants.TexfieldsName.securityCode.uppercased() {
            inputTexfield.tag = field.type.uppercased() == FieldType.text.rawValue ? Constants.Tags.fieldSecurityCode : Constants.Tags.fieldSelect
        }
        
        inputTexfield.isSecureTextEntry = field.type.uppercased() == FieldType.password.rawValue ? true : false
        
        if inputTexfield.isSecureTextEntry {
            inputTexfield.enablePasswordToggle()
        }
    }
}

// MARK: - UI
extension CredentialTableViewCell {
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14 : 16)
        label.textColor = Configuration.shared.palette.mainSubTextColor
        return label
    }
    
    func setupPaddedTextField() -> PaddedTextField {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.isSecureTextEntry = false
        textField.layer.borderColor = Configuration.shared.palette.borderTextField.cgColor
        textField.layer.borderWidth = CGFloat(1.0)
        textField.layer.cornerRadius = CGFloat(10.0)
        textField.textColor = Configuration.shared.palette.termsTextColor
        textField.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14 : 16)
        textField.setupRightImage(image: Images.lockIcon.image()!)
        return textField
    }
}

// MARK: - Layout
extension CredentialTableViewCell {
    func setupLayoutViews() {
        let cellViews = [titleLabel, inputTexfield]
        let mainStack = UIStackView(arrangedSubviews: cellViews)
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.distribution = .fill
        mainStack.alignment = .fill
        
        let titleHeight: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 18 : 21
        titleLabel.heightAnchor(equalTo: titleHeight)
        let textFieldHeight: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 40 : 46
        inputTexfield.heightAnchor(equalTo: textFieldHeight)
        
        contentView.addSubview(mainStack)
        mainStack.topAnchor(equalTo: contentView.topAnchor, constant: 8)
        mainStack.leadingAnchor(equalTo: contentView.leadingAnchor)
        mainStack.trailingAnchor(equalTo: contentView.trailingAnchor)
        mainStack.bottomAnchor(equalTo: contentView.bottomAnchor, constant: -8)
    }
}
