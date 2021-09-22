//
//  CredentialTableViewCell.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 17/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialTableViewCell: UITableViewCell {
    static let id = "CredentialTableViewCell"

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .fcBoldFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14 : 16)
        label.textColor = Configuration.shared.palette.mainColor
        return label
    }()

    var inputTexfield: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.isSecureTextEntry = false
        textField.layer.borderColor = Configuration.shared.palette.mainColor.cgColor
        textField.layer.borderWidth = CGFloat(1.0)
        textField.layer.cornerRadius = CGFloat(10.0)
        textField.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14 : 16)
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        selectionStyle = .none
        contentView.backgroundColor = Configuration.shared.palette.backgroundColor
        contentView.addSubview(titleLabel)
        contentView.addSubview(inputTexfield)

        let generalWidth = contentView.layer.frame.width - 100

        titleLabel.widthAnchor(equalTo: generalWidth)
        titleLabel.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 20 : 25)
        titleLabel.topAnchor(equalTo: contentView.topAnchor)
        titleLabel.centerXAnchor(equalTo: contentView.centerXAnchor)

        inputTexfield.widthAnchor(equalTo: generalWidth)
        inputTexfield.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35 : 40)
        inputTexfield.topAnchor(equalTo: titleLabel.bottomAnchor)
        inputTexfield.centerXAnchor(equalTo: contentView.centerXAnchor)
    }

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
