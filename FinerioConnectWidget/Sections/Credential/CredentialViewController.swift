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
    private lazy var termsTextView: VerticallyCenteredTextView = setupTermsTextView()
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
        localHideKeyboardWhenTappedAround()
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
        headerSectionView.setLockAvatarView()
        headerSectionView.titleLabel.text = Constants.Texts.CredentialSection.headerTitle
        headerSectionView.descriptionLabel.text = Constants.Texts.CredentialSection.headerDescription
        
        mainStackView.addArrangedSubview(headerSectionView)
        mainStackView.addArrangedSubview(textFieldsTableView)
        
        // Terms & Conditions
        let switchAndTermsViews = [toggleSwitch, termsTextView]
        let switchTermsStack = UIStackView(arrangedSubviews: switchAndTermsViews)
        switchTermsStack.axis = .horizontal
        switchTermsStack.spacing = 8
        switchTermsStack.alignment = .center
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
        imageView.tintColor = Configuration.shared.palette.mainColor
        imageView.addSubview(bannerStack)
        bannerStack.topAnchor(equalTo: imageView.topAnchor, constant: 5)
        bannerStack.leadingAnchor(equalTo: imageView.leadingAnchor, constant: 30)
        bannerStack.trailingAnchor(equalTo: imageView.trailingAnchor, constant: -30)
        bannerStack.bottomAnchor(equalTo: imageView.bottomAnchor, constant: -5)
        
        mainStackView.addArrangedSubview(imageView)
        
        // Separator
        let separatorView = UIView()
        separatorView.backgroundColor = .clear
        separatorView.heightAnchor(equalTo: 20)
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
    
    private func setupTermsTextView() -> VerticallyCenteredTextView {
        let textView = VerticallyCenteredTextView()
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
        
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 45).isActive = true
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
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .success, bank: self.credentialViewModel.bank))
            case .success:
                self.context?.initialize(coordinator: AccountCoordinator(context: self.context!, credentialId: self.credentialViewModel.credentialResponse.id, bank: self.credentialViewModel.bank))
            case .loaded:
                self.textFieldsTableView.heightAnchor(equalTo: self.credentialViewModel.bankFields?.count == 3 ? 270 : 190)
                self.textFieldsTableView.reloadData()
                self.continueButton.addTarget(self, action: #selector(self.createCredential), for: .touchUpInside)
                self.setupExtraData()
            case .failure:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .failure, bank: self.credentialViewModel.bank))
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

// MARK: - Keyboard Handling
extension CredentialViewController: UITextFieldDelegate {
    /// NOTE:
    /// If the keyboard has a weird behavior, try to use: UINavigationBar.appearance().isTranslucent = true
    ///
    open func localHideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    open func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    open func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {
        
        var txtFieldY : CGFloat = 0.0  //Using this we will calculate the selected textFields Y Position
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0 //Specify the space between textfield and keyboard
        
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            frame = self.view.convert(activeTextField.frame, from: activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // if textfields y is greater than keyboards y then only move View to up
                if txtFieldY >= keyBoardFrameY {
                    
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    //This condition is just to check viewOriginY should not be greator than keyboard height
                    // if its more than keyboard height then there will be black space on the top of keyboard.
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            //set the Y position of view
            self.view.frame.origin.y = -viewOriginY
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
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
}

extension UIResponder {
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}
