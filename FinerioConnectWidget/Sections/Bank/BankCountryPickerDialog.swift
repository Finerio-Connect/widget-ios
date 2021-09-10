//
//  BankCountryPickerDialog.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 09/09/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

protocol BankPickerDialogDelegate {
    func didSelectCountry(country: Country)
}

internal class BankCountryPickerDialog: GenericDialog {
    public var countryDelegate: BankPickerDialogDelegate?

    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.BankSection.titleButton, for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()

    var countries: [Country] = [] {
        didSet {
            pickerView.reloadComponent(0)
        }
    }

    private var currentSelectedIndex: Int = 0

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        [pickerView, acceptButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        pickerView.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 25)
        pickerView.topAnchor(equalTo: containerView.topAnchor, constant: 50)
        pickerView.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -25)

        acceptButton.heightAnchor(equalTo: 40)
        acceptButton.leadingAnchor(equalTo: pickerView.leadingAnchor, constant: 25)
        acceptButton.topAnchor(equalTo: pickerView.bottomAnchor, constant: 25)
        acceptButton.trailingAnchor(equalTo: pickerView.trailingAnchor, constant: -25)
        acceptButton.bottomAnchor(equalTo: containerView.bottomAnchor, constant: -25)
        acceptButton.addTarget(self, action: #selector(didSelectCountry), for: .touchUpInside)
    }

    @objc private func didSelectCountry() {
        countryDelegate?.didSelectCountry(country: countries[currentSelectedIndex])
        hide()
    }

    public func setCountry(byCode code: String = Configuration.shared.countryCode) {
        if let index = countries.firstIndex(where: { $0.code.lowercased() == code.lowercased() }) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }
}

// MARK: - Picker Delegate and Datasource methods

// MARK: -

extension BankCountryPickerDialog: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
    }

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return BankCountryPickerRowView(country: countries[row])
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedIndex = row
    }
}
