//
//  FCCredentialsFormView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 05/12/21.
//

import UIKit

protocol FCCredentialsFormViewDelegate: AnyObject {
    #warning("SON REQUERIDOS TODOS?")
    func credentialsFormView(_ credentialsFormView: FCCredentialsFormView, onActive: ServiceStatus, bank: Bank)
    func credentialsFormView(_ credentialsFormView: FCCredentialsFormView, onSuccess: ServiceStatus, bank: Bank, credentialId: String)
    func credentialsFormView(_ credentialsFormView: FCCredentialsFormView, onFailure: ServiceStatus, bank: Bank)
    func credentialsFormView(_ credentialsFormView: FCCredentialsFormView, onError: ServiceStatus, message: String)
}

class FCCredentialsFormView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var textFieldsTableView: UITableView = setupTextFieldTableView()
    private lazy var termsTextView: VerticallyCenteredTextView = setupTermsTextView()
    private lazy var toggleSwitch: UISwitch = setupToggleSwitch()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var helpButton: UIButton = setupHelpButton()
    private lazy var helpDialog: CredentialHelpDialog = setupHelpDialog()
    private lazy var extraDataDialog = setupExtraDataPickerDialog()
    private let datePicker = DatePickerDialog()
    private lazy var bannerImageView: FCBannerImageView = setupBannerView()
    
    // Vars
    private var tableHeight: CGFloat = 0 {
        didSet {
            textFieldsTableView.heightAnchor(equalTo: tableHeight)
        }
    }
    private var credentialViewModel: CredentialViewModel = CredentialViewModel()
    private var credential = Credential(widgetId: Configuration.shared.widgetId,
                                        customerName: Configuration.shared.customerName,
                                        automaticFetching: Configuration.shared.automaticFetching,
                                        state: Configuration.shared.state)
    private var securityCodeTextField: UITextField?
    private var extraData: ExtraData?
    public var delegate: FCCredentialsFormViewDelegate?
    
    // Inits
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

// MARK: - Data
extension  FCCredentialsFormView {
    public func setBank(_ bank: Bank) {
        self.credentialViewModel.bank = bank
        
        self.loadingView.start()
        trackEvent(eventName: Constants.Events.bankSelected, [Constants.Events.bankSelected: credentialViewModel.bank.code])
        
        observerServiceStatus()
        credentialViewModel.loadBankFields()
    }
}

// MARK: - Actions
extension FCCredentialsFormView {
    @objc private func didButtonHelp() {
        DispatchQueue.main.async {
            self.helpDialog.imageURL = Constants.URLS.helpWithCredentialsGif.replacingOccurrences(of: Constants.Placeholders.bankCode, with: self.credentialViewModel.bank.code)
            self.helpDialog.show()
        }
    }
    
    @objc private func createCredential() {
        self.loadingView.start()
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

// MARK: - UI
extension FCCredentialsFormView {
    override func configureView() {
        super.configureView()
        self.loadingView.backgroundColor = .white
        
        localHideKeyboardWhenTappedAround()
        addComponents()
    }
    
    func addComponents() {
        let spacing: CGFloat = 20
        
        // Header
        addSubview(headerSectionView)
        headerSectionView.topAnchor(equalTo: topAnchor, constant: spacing / 2)
        headerSectionView.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        headerSectionView.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        
        // Table
        addSubview(textFieldsTableView)
        textFieldsTableView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: spacing / 2)
        textFieldsTableView.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        textFieldsTableView.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        
        //Banner
        addSubview(bannerImageView)
        bannerImageView.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        bannerImageView.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        
        //Buttons
        addSubview(helpButton)
        helpButton.bottomAnchor(equalTo: bannerImageView.topAnchor, constant: -spacing)
        helpButton.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        helpButton.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        
        addSubview(continueButton)
        continueButton.bottomAnchor(equalTo: helpButton.topAnchor, constant: -12)
        continueButton.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        continueButton.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        
        // Terms & Conditions
        addSubview(termsTextView)
        termsTextView.topAnchor(equalTo: textFieldsTableView.bottomAnchor, constant: spacing / 2)
        termsTextView.bottomAnchor(equalTo: continueButton.topAnchor, constant: -spacing)
        termsTextView.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        
        addSubview(toggleSwitch)
        toggleSwitch.centerYAnchor(equalTo: termsTextView.centerYAnchor)
        toggleSwitch.leadingAnchor(equalTo: leadingAnchor, constant: spacing)
        toggleSwitch.trailingAnchor(equalTo: termsTextView.leadingAnchor, constant: -8)
    }
    
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.titleLabel.text = Constants.Texts.CredentialSection.headerTitle
        headerView.descriptionLabel.text = Constants.Texts.CredentialSection.headerDescription
        headerView.setLockAvatarView()
        return headerView
    }
    
    private func setupBannerView() -> FCBannerImageView {
        let bannerView = FCBannerImageView()
        return bannerView
    }
    
    private func setupTextFieldTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(CredentialTableViewCell.self, forCellReuseIdentifier: CredentialTableViewCell.id)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? true : false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        return tableView
    }
    
    private func setupTermsTextView() -> VerticallyCenteredTextView {
        let textView = VerticallyCenteredTextView()
        let plainAttributes: [NSAttributedString.Key: Any]
        let linkAttributes: [NSAttributedString.Key : Any]
        
        let plainText = Constants.Texts.CredentialSection.plainTyCText
        let termsColor = Configuration.shared.palette.termsTextColor
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 10 : 12
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
        
        textView.heightAnchor(equalTo: 40)
        textView.backgroundColor = .clear
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
    
    private func setupHelpDialog() -> CredentialHelpDialog {
        let helpDialog = CredentialHelpDialog()
        superview?.addSubview(helpDialog)
        let screenSize: CGRect = UIScreen.main.bounds
        helpDialog.frame = screenSize
        return helpDialog
    }
    
    private func setupExtraDataPickerDialog() -> ExtraDataPickerDialog {
        let pickerDialog = ExtraDataPickerDialog()
        pickerDialog.extraDataDelegate = self
        superview?.addSubview(pickerDialog)
        let screenSize: CGRect = UIScreen.main.bounds
        pickerDialog.frame = screenSize
        return pickerDialog
    }
}


// MARK: - Observers View Model
extension FCCredentialsFormView {
    private func observerServiceStatus() {
        credentialViewModel.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.loadingView.stop()
            
            switch status {
            case .updated, .interactive: break
                
            case .active:
                print("Active")
                self.delegate?.credentialsFormView(self,
                                                   onActive: .success, //success status is correct, not a typo.
                                                   bank: self.credentialViewModel.bank)
                
            case .success:
                print("Success")
                self.delegate?.credentialsFormView(self,
                                                   onSuccess: .success,
                                                   bank: self.credentialViewModel.bank,
                                                   credentialId: self.credentialViewModel.credentialResponse.id)
                
            case .loaded:
                self.textFieldsTableView.reloadData()
                
                // Calculate TableHeight
                let numberOfRows = self.textFieldsTableView.numberOfRows(inSection: 0)
                if let rowHeight = self.textFieldsTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame.height {
                    let height = CGFloat(numberOfRows) * rowHeight
                    self.tableHeight = height
                }
                
                self.continueButton.addTarget(self, action: #selector(self.createCredential), for: .touchUpInside)
                self.setupExtraData()
                
            case .failure:
                print("Failure")
                self.delegate?.credentialsFormView(self,
                                                   onFailure: .failure,
                                                   bank: self.credentialViewModel.bank)
                
            case .error:
                print("Failure case, not implemented")
#warning("Revisar con René donde viviría la propiedad App o en su defecto la funcion ShowAlert")
                //                self.app.showAlert(self.credentialViewModel.errorMessage, viewController: self)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FCCredentialsFormView: UITableViewDataSource {
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

// MARK: - Extra Data Picker Dialog Delegate
extension FCCredentialsFormView: ExtraDataPickerDialogDelegate {
    func didSelectExtraData(extraData: ExtraData) {
        self.extraData = extraData
        securityCodeTextField?.text = extraData.value
        buttonValidation(securityCodeTextField!)
    }
}

// MARK: - Keyboard Handling
extension FCCredentialsFormView: UITextFieldDelegate {
    /// NOTE:
    /// If the keyboard has a weird behavior, try to use: UINavigationBar.appearance().isTranslucent = true
    ///
    open func localHideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
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
            frame = convert(activeTextField.frame, from: activeTextField.superview)
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
            frame.origin.y = -viewOriginY
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
