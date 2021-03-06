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
        label.font = UIFont(name: Configuration.shared.texts.mainFont, size: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14.0 : 16.0)?.bold()
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
        textField.font = UIFont(name: Configuration.shared.texts.mainFont, size: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14.0 : 16.0)
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
        titleLabel.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 20.0 : 25.0)
        titleLabel.topAnchor(equalTo: contentView.topAnchor)
        titleLabel.centerXAnchor(equalTo: contentView.centerXAnchor)

        inputTexfield.widthAnchor(equalTo: generalWidth)
        inputTexfield.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0)
        inputTexfield.topAnchor(equalTo: titleLabel.bottomAnchor)
        inputTexfield.centerXAnchor(equalTo: contentView.centerXAnchor)
    }

    func setup(with field: BankField) {
        titleLabel.text = field.friendlyName
        inputTexfield.placeholder = field.friendlyName
        inputTexfield.id = field.name
        inputTexfield.tag = field.name.uppercased() == FieldType.securityCode.rawValue ? Constants.Tags.fieldSecurityCode : 0
        inputTexfield.isSecureTextEntry = field.type.uppercased() == FieldType.password.rawValue ? true : false
    }
}
