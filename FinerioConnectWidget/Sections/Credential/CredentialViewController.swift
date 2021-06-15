//
//  CredentialViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialViewController: BaseViewController {
    internal var credentialViewModel: CredentialViewModel!

    fileprivate lazy var titleLabel: UILabel = setupTitleLabel()
    fileprivate lazy var logoBankImageView: UIImageView = setupLogoBankImageView()
    fileprivate lazy var helpWithCredentialsButton: UIButton = setupHelpWithCredentialsButton()
    fileprivate lazy var textFieldsTableView: UITableView = setupTextFieldTableView()
    fileprivate lazy var tyCLabel: InteractiveLinkLabel = setupTyCLabel()
    fileprivate lazy var continueButton: UIButton = setupContinueButton()

    let datePicker = DatePickerDialog()
    var credential = Credential(widgetId: Configuration.shared.widgetId, customerName: Configuration.shared.customerName, automaticFetching: Configuration.shared.automaticFetching, state: Configuration.shared.state)
    var securityCodeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        startLoader()
        credentialViewModel = viewModel as? CredentialViewModel
        hideKeyboardWhenTappedAround()
        configureView()
        observerServiceStatus()
        credentialViewModel.loadBankFields()

        //        bankImageView.image = Images.eyeOpen.image()?.withRenderingMode(.alwaysTemplate)
    }

    private func configureView() {
        title = credentialViewModel.getTitle()

        [titleLabel, logoBankImageView, helpWithCredentialsButton, textFieldsTableView, tyCLabel, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        let generalWidth = view.layer.frame.width - 100

        titleLabel.widthAnchor(equalTo: generalWidth)
        titleLabel.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 20.0, secondValue: 50.0))
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        logoBankImageView.setImage(with: URL(string: Constants.URLS.bankImageOn.replacingOccurrences(of: Constants.Placeholders.bankId, with: credentialViewModel.bank.id)))
        logoBankImageView.widthAnchor(equalTo: (view.layer.frame.width - getConstraintConstant(firstValue: 35.0, secondValue: 25.0)) / 2)
        logoBankImageView.heightAnchor(equalTo: ((view.layer.frame.width - getConstraintConstant(firstValue: 35.0, secondValue: 25.0)) / 2) / 2)
        logoBankImageView.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20)
        logoBankImageView.centerXAnchor(equalTo: view.centerXAnchor)

        helpWithCredentialsButton.topAnchor(equalTo: logoBankImageView.bottomAnchor, constant: getConstraintConstant(firstValue: 10.0, secondValue: 20.0))
        helpWithCredentialsButton.leadingAnchor(equalTo: view.leadingAnchor)
        helpWithCredentialsButton.trailingAnchor(equalTo: view.trailingAnchor)

        textFieldsTableView.topAnchor(equalTo: helpWithCredentialsButton.bottomAnchor, constant: getConstraintConstant(firstValue: 10.0, secondValue: 20.0))
        textFieldsTableView.leadingAnchor(equalTo: view.leadingAnchor)
        textFieldsTableView.trailingAnchor(equalTo: view.trailingAnchor)

        tyCLabel.widthAnchor(equalTo: generalWidth)
        tyCLabel.heightAnchor(equalTo: 100)
        tyCLabel.topAnchor(equalTo: textFieldsTableView.bottomAnchor, constant: 10)
        tyCLabel.centerXAnchor(equalTo: view.centerXAnchor)

        continueButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        continueButton.widthAnchor(equalTo: generalWidth)
        continueButton.bottomAnchor(equalTo: view.safeBottomAnchor, constant: getConstraintConstant(firstValue: -20.0, secondValue: -30.0))
        continueButton.centerXAnchor(equalTo: view.centerXAnchor)
    }
}

// MARK: - UI

extension CredentialViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Configuration.shared.texts.createCredentialTitle.replacingOccurrences(of: Constants.Placeholders.bankName, with: credentialViewModel.bank.name)
        label.font = .fcBoldFont(ofSize: getConstraintConstant(firstValue: 16.0, secondValue: 20.0))
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupLogoBankImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private func setupHelpWithCredentialsButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.CredentialSection.helpWithCredentialsLabel, for: .normal)
        button.setTitleColor(Configuration.shared.palette.mainTextColor, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 13.0 : 15.0)
        button.setAttributedTitle(NSAttributedString(string: button.titleLabel!.text ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        button.addTarget(self, action: #selector(didButtonHelp), for: .touchUpInside)
        return button
    }

    private func setupTextFieldTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(CredentialTableViewCell.self, forCellReuseIdentifier: CredentialTableViewCell.id)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? true : false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = view.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }

    private func setupTyCLabel() -> InteractiveLinkLabel {
        let label = InteractiveLinkLabel()
        label.numberOfLines = 0
        label.text = Constants.Texts.CredentialSection.tyCLabel
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12.0 : 14.0)
        label.textAlignment = .center
        label.textColor = Configuration.shared.palette.termsTextColor

        let plainAttributedString = NSMutableAttributedString(string: "Al dar clic en Enviar información aceptas expresamente nuestros ", attributes: nil)
        let string = "Términos de servicio"
        let attributedLinkString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.link: URL(string: Configuration.shared.texts.termsAndConditionsUrl)!])

        let plainAttributedString2 = NSMutableAttributedString(string: " así como nuestro ", attributes: nil)
        let string2 = "Aviso de privacidad"
        let attributedLinkString2 = NSMutableAttributedString(string: string2, attributes: [NSAttributedString.Key.link: URL(string: Configuration.shared.texts.privacyTermsUrl)!])

        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        fullAttributedString.append(plainAttributedString2)
        fullAttributedString.append(attributedLinkString2)
        fullAttributedString.append(NSMutableAttributedString(string: ".", attributes: nil))

        label.attributedText = fullAttributedString

        return label
    }

    private func setupContinueButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Configuration.shared.texts.submitLabel, for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: 18.0)
        button.alpha = 0.5
        button.isEnabled = false
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }
}

// MARK: - Actions

extension CredentialViewController {
    @objc private func didButtonHelp() {
        let popup = Popup()
        popup.setImage(UIImage.gifImageWithURL(Constants.URLS.helpWithCredentialsGif.replacingOccurrences(of: Constants.Placeholders.bankId, with: credentialViewModel.bank.id)))

        view.addSubview(popup)
        popup.centerXAnchor(equalTo: view.centerXAnchor)
        popup.centerYAnchor(equalTo: view.centerYAnchor)
        popup.heightAnchor(equalTo: view.bounds.height)
        popup.widthAnchor(equalTo: view.bounds.width)
    }

    @objc private func createCredential() {
        startLoader()
        getTextFeildValuesFromTableView()

        credential.bankId = credentialViewModel.bank.id
        credential.customerName = Configuration.shared.customerName
        credential.customerId = Configuration.shared.customerId

        credentialViewModel.bankFields.forEach { textfield in
            if textfield.name == Constants.TexfieldsName.username {
                credential.username = HelperEncrypt().encrypted(textfield.value)
            }

            if textfield.name == Constants.TexfieldsName.securityCode {
                credential.securityCode = HelperEncrypt().encrypted(textfield.value)
            }

            if textfield.name == Constants.TexfieldsName.password {
                credential.password = HelperEncrypt().encrypted(textfield.value)
            }
        }

        credentialViewModel.createCredential(credential: credential)
    }

    func getTextFeildValuesFromTableView() {
        for (index, _) in credentialViewModel.bankFields.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = textFieldsTableView.cellForRow(at: indexPath) as? CredentialTableViewCell else {
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
}

// MARK: - Observers View Model

extension CredentialViewController {
    private func observerServiceStatus() {
        credentialViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.stopLoader()
            switch status {
            case .active:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .success))
            case .success:
                self.context?.initialize(coordinator: AccountCoordinator(context: self.context!, credentialId: self.credentialViewModel.credentialResponse.id))
            case .loaded:
                self.textFieldsTableView.heightAnchor(equalTo: self.credentialViewModel.bankFields?.count == 3 ? 230 : 150)
                self.textFieldsTableView.reloadData()
                self.continueButton.addTarget(self, action: #selector(self.createCredential), for: .touchUpInside)
            case .failure:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .failure))
            case .updated: break
            case .interactive: break
            case .error:
                self.app.showAlert(self.credentialViewModel.errorMessage, viewController: self)
            }
        }
    }

    private func animateViewMoving(up: Bool, moveValue: CGFloat) {
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        view.frame = view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

// MARK: UITableViewDataSource

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

// MARK: UITableViewDelegate

extension CredentialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 65.0 : 75.0
    }
}

// MARK: UITextFieldDelegate

extension CredentialViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == Constants.Tags.fieldSecurityCode {
            securityCodeTextField = textField
            datePickerTapped(textField)
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
