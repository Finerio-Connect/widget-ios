//
//  CredentialViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialViewController: BaseViewController {
    // Components
    private lazy var textFieldsTableView: UITableView = setupTextFieldTableView()
    private lazy var tyCLabel: UITextView = setupTyCLabel()
    private lazy var toggleSwitch: UISwitch = setupToggleSwitch()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var helpButton: UIButton = setupHelpButton()
    private lazy var helpDialog = CredentialHelpDialog()
    private lazy var extraDataDialog = ExtraDataPickerDialog()
    private let datePicker = DatePickerDialog()
    // Vars
    private var credentialViewModel: CredentialViewModel!
    private var credential = Credential(widgetId: Configuration.shared.widgetId, customerName: Configuration.shared.customerName, automaticFetching: Configuration.shared.automaticFetching, state: Configuration.shared.state)
    private var securityCodeTextField: UITextField?
    private var extraData: ExtraData?

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoader()
        credentialViewModel = viewModel as? CredentialViewModel
        hideKeyboardWhenTappedAround()
        configureView()
        observerServiceStatus()
        credentialViewModel.loadBankFields()

        trackEvent(eventName: Constants.Events.bankSelected, [Constants.Events.bankSelected: credentialViewModel.bank.code])
    }
    
    private func configureView() -> Void {
        title = credentialViewModel.getTitle()
        extraDataDialog.extraDataDelegate = self
                
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing

        let headerSectionView = HeaderSectionView()
        headerSectionView.titleLabel.text = Constants.Texts.CredentialSection.headerTitle
        headerSectionView.descriptionLabel.text = Constants.Texts.CredentialSection.headerDescription
        
        mainStackView.addArrangedSubview(headerSectionView)
        mainStackView.addArrangedSubview(textFieldsTableView)
        
        // Terms & Conditions
        let switchAndTermsViews = [toggleSwitch, tyCLabel]
        let switchTermsStack = UIStackView(arrangedSubviews: switchAndTermsViews)
        switchTermsStack.axis = .horizontal
        switchTermsStack.spacing = 8
        mainStackView.addArrangedSubview(switchTermsStack)
        
        // Buttons
        let buttons = [continueButton, helpButton]
        let buttonsStack = UIStackView(arrangedSubviews: buttons)
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 12
        mainStackView.addArrangedSubview(buttonsStack)
        
        // Banner
        let bannerStack = UIStackView()
        bannerStack.axis = .horizontal
        bannerStack.alignment = .center
        bannerStack.spacing = 8
        
        let lockImageView = UIImageView(image: Images.lockIcon.image())
        lockImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        lockImageView.tintColor = Configuration.shared.palette.termsTextColor
        bannerStack.addArrangedSubview(lockImageView)
        
        let bannerLabel = UILabel()
        bannerLabel.text = Constants.Texts.CredentialSection.bannerText
        bannerLabel.numberOfLines = 0
        bannerLabel.lineBreakMode = .byWordWrapping
        bannerLabel.textColor = Configuration.shared.palette.termsTextColor
        let fontSize = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 10 : 12
        bannerLabel.font = .fcRegularFont(ofSize: CGFloat(fontSize))

        bannerStack.addArrangedSubview(bannerLabel)
        
        let tapeBannerImg = Images.tapeBanner.image()
        let imageView = UIImageView(image: tapeBannerImg)
        imageView.addSubview(bannerStack)
        bannerStack.topAnchor(equalTo: imageView.topAnchor, constant: 5)
        bannerStack.leadingAnchor(equalTo: imageView.leadingAnchor, constant: 30)
        bannerStack.trailingAnchor(equalTo: imageView.trailingAnchor, constant: -30)
        bannerStack.bottomAnchor(equalTo: imageView.bottomAnchor, constant: -5)
        
        mainStackView.addArrangedSubview(imageView)
        
        // Separator
        let separatorView = UIView()
        separatorView.backgroundColor = .clear
        separatorView.heightAnchor(equalTo: 25)
        mainStackView.addArrangedSubview(separatorView)
        
        view.addSubview(mainStackView)
        mainStackView.topAnchor(equalTo: view.safeTopAnchor, constant: 20)
        mainStackView.leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
        mainStackView.trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
        mainStackView.bottomAnchor(equalTo: view.safeBottomAnchor, constant: -20)
        
        // DIALOGS
        view.addSubview(helpDialog)
        helpDialog.centerXAnchor(equalTo: view.centerXAnchor)
        helpDialog.centerYAnchor(equalTo: view.centerYAnchor)
        helpDialog.heightAnchor(equalTo: view.bounds.height)
        helpDialog.widthAnchor(equalTo: view.bounds.width)

        view.addSubview(extraDataDialog)
        extraDataDialog.centerXAnchor(equalTo: view.centerXAnchor)
        extraDataDialog.centerYAnchor(equalTo: view.centerYAnchor)
        extraDataDialog.heightAnchor(equalTo: view.bounds.height)
        extraDataDialog.widthAnchor(equalTo: view.bounds.width)
    }

//    private func OLDconfigureView() {
//        title = credentialViewModel.getTitle()
//
//        extraDataDialog.extraDataDelegate = self
//
//        [textFieldsTableView, tyCLabel, continueButton, helpDialog, extraDataDialog].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//
//        let generalWidth = view.layer.frame.width - 100
//
////        titleLabel.widthAnchor(equalTo: generalWidth)
////        titleLabel.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 10, secondValue: 20))
////        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)
////
////        logoBankImageView.setImage(with: URL(string: Constants.URLS.bankImageOn.replacingOccurrences(of: Constants.Placeholders.bankCode, with: credentialViewModel.bank.code)), defaultImage: Images.otherBanksOn.image())
////        logoBankImageView.widthAnchor(equalTo: (view.layer.frame.width - getConstraintConstant(firstValue: 35, secondValue: 25)) / 2)
////        logoBankImageView.heightAnchor(equalTo: ((view.layer.frame.width - getConstraintConstant(firstValue: 35, secondValue: 25)) / 2) / 2)
////        logoBankImageView.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20)
////        logoBankImageView.centerXAnchor(equalTo: view.centerXAnchor)
//
////        helpWithCredentialsButton.topAnchor(equalTo: logoBankImageView.bottomAnchor, constant: getConstraintConstant(firstValue: 10, secondValue: 20))
////        helpWithCredentialsButton.leadingAnchor(equalTo: view.leadingAnchor)
////        helpWithCredentialsButton.trailingAnchor(equalTo: view.trailingAnchor)
//
////        textFieldsTableView.topAnchor(equalTo: helpWithCredentialsButton.bottomAnchor, constant: getConstraintConstant(firstValue: 10, secondValue: 20))
////        textFieldsTableView.leadingAnchor(equalTo: view.leadingAnchor)
////        textFieldsTableView.trailingAnchor(equalTo: view.trailingAnchor)
////
////        tyCLabel.widthAnchor(equalTo: generalWidth)
////        tyCLabel.heightAnchor(equalTo: 100)
////        tyCLabel.topAnchor(equalTo: textFieldsTableView.bottomAnchor, constant: 10)
////        tyCLabel.centerXAnchor(equalTo: view.centerXAnchor)
//
//        continueButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40, secondValue: 50))
//        continueButton.widthAnchor(equalTo: generalWidth)
//        continueButton.bottomAnchor(equalTo: view.safeBottomAnchor, constant: getConstraintConstant(firstValue: -20, secondValue: -30))
//        continueButton.centerXAnchor(equalTo: view.centerXAnchor)
//
//        helpDialog.centerXAnchor(equalTo: view.centerXAnchor)
//        helpDialog.centerYAnchor(equalTo: view.centerYAnchor)
//        helpDialog.heightAnchor(equalTo: view.bounds.height)
//        helpDialog.widthAnchor(equalTo: view.bounds.width)
//
//        extraDataDialog.centerXAnchor(equalTo: view.centerXAnchor)
//        extraDataDialog.centerYAnchor(equalTo: view.centerYAnchor)
//        extraDataDialog.heightAnchor(equalTo: view.bounds.height)
//        extraDataDialog.widthAnchor(equalTo: view.bounds.width)
//    }
}

// MARK: - Private methods

extension CredentialViewController {
    private func setupExtraData() {
        for (index, _) in credentialViewModel.bankFields.enumerated() {
            guard let cell = textFieldsTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CredentialTableViewCell else {
                return
            }

            if cell.inputTexfield.id?.uppercased() == Constants.TexfieldsName.securityCode.uppercased() {
                securityCodeTextField = cell.inputTexfield
            }

            if cell.inputTexfield.tag == Constants.Tags.fieldSelect {
                if let bankField = credentialViewModel.bankFields.first(where: { $0.name == cell.inputTexfield.id }) {
                    extraDataDialog.extraData = bankField.extraData ?? []

                    cell.inputTexfield.text = bankField.extraData?.first?.value
                    extraData = bankField.extraData?.first
                    securityCodeTextField?.text = extraData?.value
                    buttonValidation(securityCodeTextField!)
                    extraDataDialog.setExtraData(byName: bankField.extraData?.first?.name ?? "")
                }
            }
        }
    }
}

// MARK: - Dialog Country Delegate

extension CredentialViewController: ExtraDataPickerDialogDelegate {
    func didSelectExtraData(extraData: ExtraData) {
        self.extraData = extraData
        securityCodeTextField?.text = extraData.value
        buttonValidation(securityCodeTextField!)
    }
}

// MARK: - UI

extension CredentialViewController {
    private func setupTextFieldTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(CredentialTableViewCell.self, forCellReuseIdentifier: CredentialTableViewCell.id)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? true : false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = view.backgroundColor
        tableView.dataSource = self
        return tableView
    }
    
    private func setupTyCLabel() -> UITextView {
        let textView = UITextView()
        let plainAttributes: [NSAttributedString.Key: Any]
        let linkAttributes: [NSAttributedString.Key : Any]
        
        let plainText = Constants.Texts.CredentialSection.plainTyCText
        let termsColor = Configuration.shared.palette.termsTextColor
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14
        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
        
        plainAttributes = [.foregroundColor: termsColor, .font: fontType]
        let attributedString = NSMutableAttributedString(string: plainText,
                                                         attributes: plainAttributes)
        
        let linkedText = Constants.Texts.CredentialSection.linkedTyCText
        let linkRange = (attributedString.string as NSString).range(of: linkedText)
        
        let urlWebSite = Constants.URLS.termsAndConditions
        attributedString.addAttribute(NSAttributedString.Key.link, value: urlWebSite, range: linkRange)
        
        let linkColor = Configuration.shared.palette.mainTextColor
        linkAttributes = [.foregroundColor: linkColor, .font: fontType]
        
        textView.linkTextAttributes = linkAttributes
        textView.attributedText = attributedString
        textView.isEditable = false
        return textView
    }
    
    private func setupToggleSwitch() -> UISwitch {
        let toggleSwitch = UISwitch()
        toggleSwitch.onTintColor = Configuration.shared.palette.mainColor
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged), for: .valueChanged)
        return toggleSwitch
    }

    private func setupContinueButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.CredentialSection.continueButtonTitle, for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.heightAnchor(equalTo: 46)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: 18)
        button.alpha = 0.5
        button.isEnabled = false
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }
    
    private func setupHelpButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.CredentialSection.helpWithCredentialsLabel, for: .normal)
        button.backgroundColor = Configuration.shared.palette.grayBackgroundColor
        button.heightAnchor(equalTo: 46)
        button.setTitleColor(Configuration.shared.palette.mainSubTextColor, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didButtonHelp), for: .touchUpInside)
        return button
    }
}

// MARK: - Actions

extension CredentialViewController {
    @objc private func didButtonHelp() {
        DispatchQueue.main.async {
            self.helpDialog.imageURL = Constants.URLS.helpWithCredentialsGif.replacingOccurrences(of: Constants.Placeholders.bankCode, with: self.credentialViewModel.bank.code)
            self.helpDialog.show()
        }
    }

    @objc private func createCredential() {
        startLoader()
        getTextFieldValuesFromTableView()

        credential.bankId = credentialViewModel.bank.id
        credential.customerName = Configuration.shared.customerName
        credential.customerId = Configuration.shared.customerId

        credentialViewModel.bankFields.forEach { textfield in
            if textfield.name == Constants.TexfieldsName.username {
                credential.username = HelperEncrypt().encrypted(textfield.value)
            }

            if textfield.name == Constants.TexfieldsName.securityCode {
                credential.securityCode = HelperEncrypt().encrypted(extraData != nil ? extraData!.name : textfield.value)
            }

            if textfield.name == Constants.TexfieldsName.password {
                credential.password = HelperEncrypt().encrypted(textfield.value)
            }
        }

        credentialViewModel.createCredential(credential: credential)
    }

    func getTextFieldValuesFromTableView() {
        for (index, _) in credentialViewModel.bankFields.enumerated() {
            guard let cell = textFieldsTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CredentialTableViewCell else {
                return
            }

            if let text = cell.inputTexfield.text, !text.isEmpty {
                credentialViewModel.bankFields[index].value = text
            }
        }
    }

    func datePickerTapped(_ textField: UITextField) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -150
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)

        datePicker.show(Constants.Texts.CredentialSection.titleDatePicker,
                        doneButtonTitle: Constants.Texts.CredentialSection.doneButtonTitleDatePicker,
                        cancelButtonTitle: Constants.Texts.CredentialSection.cancelButtonTitleDatePicker,
                        minimumDate: threeMonthAgo, maximumDate: currentDate, datePickerMode: .date) { date in

            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                self.securityCodeTextField?.text = formatter.string(from: dt)
                self.buttonValidation(textField)
            }
        }
    }

    @objc private func buttonValidation(_ textField: UITextField) {
        credentialViewModel.textFieldDidChange(textField)
        continueButton.alpha = credentialViewModel.validForm ? 1.0 : 0.5
        continueButton.isEnabled = credentialViewModel.validForm ? true : false
    }
    
    @objc private func toggleSwitchChanged() {
        credentialViewModel.isAcceptingTerms = toggleSwitch.isOn
        continueButton.alpha = credentialViewModel.validForm ? 1.0 : 0.5
        continueButton.isEnabled = credentialViewModel.validForm ? true : false
    }
}

// MARK: - Observers View Model

extension CredentialViewController {
    private func observerServiceStatus() {
        credentialViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.stopLoader()
            switch status {
            case .updated, .interactive: break
            case .active:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .success))
            case .success:
                self.context?.initialize(coordinator: AccountCoordinator(context: self.context!, credentialId: self.credentialViewModel.credentialResponse.id))
            case .loaded:
                self.textFieldsTableView.heightAnchor(equalTo: self.credentialViewModel.bankFields?.count == 3 ? 270 : 190)
                self.textFieldsTableView.reloadData()
                self.continueButton.addTarget(self, action: #selector(self.createCredential), for: .touchUpInside)
                self.setupExtraData()
            case .failure:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .failure))
            case .error:
                self.app.showAlert(self.credentialViewModel.errorMessage, viewController: self)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CredentialViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentialViewModel.bankFields?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CredentialTableViewCell.id, for: indexPath) as? CredentialTableViewCell else {
            fatalError("Could not cast CredentialTableViewCell")
        }

        cell.setup(with: credentialViewModel.bankFields[indexPath.row])
        cell.inputTexfield.delegate = self
        cell.inputTexfield.addTarget(self, action: #selector(buttonValidation(_:)), for: .editingChanged)

        return cell
    }
}

// MARK: - UITextFieldDelegate

extension CredentialViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == Constants.Tags.fieldSecurityCode {
            securityCodeTextField = textField
            datePickerTapped(textField)
            return false
        }

        if textField.tag == Constants.Tags.fieldSelect {
            extraDataDialog.show()
            return false
        }

        return true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let textFieldRect: CGRect = view.window!.convert(textField.bounds, from: textField)
        let viewRect: CGRect = view.window!.convert(view.bounds, from: view)

        let midline: CGFloat = textFieldRect.origin.y + 0.5 * textFieldRect.size.height
        let numerator: CGFloat = midline - viewRect.origin.y - Constants.MoveKeyboard.MINIMUM_SCROLL_FRACTION * viewRect.size.height
        let denominator: CGFloat = (Constants.MoveKeyboard.MAXIMUM_SCROLL_FRACTION - Constants.MoveKeyboard.MINIMUM_SCROLL_FRACTION) * viewRect.size.height
        var heightFraction: CGFloat = numerator / denominator

        if heightFraction < 0.0 {
            heightFraction = 0.0
        } else if heightFraction > 1.0 {
            heightFraction = 1.0
        }

        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        if orientation == UIInterfaceOrientation.portrait || orientation == UIInterfaceOrientation.portraitUpsideDown {
            animateDistance = floor(Constants.MoveKeyboard.PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        } else {
            animateDistance = floor(Constants.MoveKeyboard.LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }

        var viewFrame: CGRect = view.frame
        viewFrame.origin.y -= animateDistance

        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(Constants.MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        view.frame = viewFrame
        UIView.commitAnimations()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        var viewFrame: CGRect = view.frame
        viewFrame.origin.y += CGFloat(animateDistance)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(Constants.MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        view.frame = viewFrame
        UIView.commitAnimations()
    }
}
