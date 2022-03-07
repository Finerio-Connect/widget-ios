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
        changeStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Data
extension CredentialTableViewCell {
    func setup(with field: BankField) {
        titleLabel.text = field.friendlyName
        
        let palette = Configuration.shared.palette
        inputTexfield.attributedPlaceholder = NSAttributedString (
            string: field.friendlyName,
            attributes: [.foregroundColor: palette.credentialsFieldsTextPlaceholder.dynamicColor]
        )
        
        inputTexfield.id = field.name
        inputTexfield.tag = tagForTextFieldType(field.type)
        
        // OLD
        //            inputTexfield.tag = field.type.uppercased() == FieldType.text.rawValue ? Constants.Tags.fieldSecurityCode : Constants.Tags.fieldSelect
        
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
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14)
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
        textField.layer.borderWidth = CGFloat(1.0)
        textField.layer.cornerRadius = CGFloat(10.0)
        textField.font = .fcMediumFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14)
        textField.setupRightImage(image: Images.lockIcon.image()!)
        return textField
    }
    
    func tagForTextFieldType(_ textFieldType: String) -> Int {
        switch textFieldType.uppercased() {
        case FieldType.text.rawValue:
            return Constants.FieldType.plainText
            
        case FieldType.password.rawValue:
            return Constants.FieldType.passwordText
            
        case FieldType.select.rawValue:
            return Constants.FieldType.selectorOptions
            
        default:
            return Constants.FieldType.plainText
        }
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

// MARK: - Style
extension CredentialTableViewCell {
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        titleLabel.textColor = palette.credentialsFieldsTitle.dynamicColor
        inputTexfield.textColor = palette.credentialsFieldsText.dynamicColor
    }
}
