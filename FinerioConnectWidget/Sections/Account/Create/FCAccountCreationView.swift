//
//  FCAccountCreationView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 08/12/21.
//

import Foundation
import nanopb
import UIKit

protocol FCAccountCreationViewDelegate: AnyObject {
    func accountCreationView(_ accountCreationView: FCAccountCreationView, accountCreated: CredentialAccount) // Optional
    func accountCreationView(_ accountCreationView: FCAccountCreationView, onSuccess: ServiceStatus, bank: Bank)
    func accountCreationView(_ accountCreationView: FCAccountCreationView, onFailure: ServiceStatus, message: String, bank: Bank)
}

extension FCAccountCreationViewDelegate {
    func accountCreationView(_ accountCreationView: FCAccountCreationView, accountCreated: CredentialAccount) {}
}

class FCAccountCreationView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var accountLoaderView: FCLoaderAnimationView = setupLoaderAnimationView()
    private lazy var statusDescriptionLabel: UILabel = setupStatusDescriptionLabel()
    // Vars
    private var accountViewModel: AccountViewModel = AccountViewModel()
    var credentialToken = CredentialToken(widgetId: Configuration.shared.widgetId)
    public var delegate: FCAccountCreationViewDelegate?
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    deinit {
        accountLoaderView.stop()
        accountViewModel.databaseReference.removeAllObservers()
    }
    
    override func configureView() {
        super.configureView()
        trackEvent(eventName: Constants.Events.createCredential)
        setLayoutViews()
    }
}

// MARK: - Data
extension FCAccountCreationView {
    public func setBank(_ bank: Bank, credentialId: String) {
        accountViewModel.bank = bank
        accountViewModel.credentialId = credentialId
        
        setBankAvatar()
        
        observerServiceStatus()
        accountViewModel.firebaseObserver()
    }
}

// MARK: - UI
extension FCAccountCreationView {
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.titleLabel.text = Constants.Texts.AccountSection.headerTitle
        headerView.descriptionLabel.text = Constants.Texts.AccountSection.headerDescription
        return headerView
    }
    
    private func setBankAvatar() {
        let defaultImage = Images.otherBanksOff.image()
        let bankCodePlaceholder = Constants.Placeholders.bankCode
        let imageName = Constants.URLS.bankImageShield.replacingOccurrences(of: bankCodePlaceholder,
                                                                            with: accountViewModel.bank.code)
        headerSectionView.avatarView.setImage(with: URL(string: imageName), defaultImage: defaultImage)
    }
    
    private func setupLoaderAnimationView() -> FCLoaderAnimationView {
        let loaderView = FCLoaderAnimationView()
        loaderView.animationSource = Configuration.shared.animations.accountCreationAnimation
        loaderView.backgroundColor = .clear
        loaderView.start()
        return loaderView
    }
    
    private func setupStatusDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Configuration.shared.palette.mainTextColor
        label.font = .fcBoldFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14.0 : 16.0)
        label.text = Constants.Texts.AccountSection.creationSteps[0]
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }
    
    private func showCreationSteps() {
        let serialQueue = DispatchQueue(label: "serialQueueSteps")
        let steps = Constants.Texts.AccountSection.creationSteps
        steps.forEach { step in
            if step != steps[0] {
                serialQueue.async {
                    sleep(for: 5)
                    DispatchQueue.main.async {
                        self.statusDescriptionLabel.text = step
                    }
                }
            }
        }
    }
}

// MARK: - Layouts
extension FCAccountCreationView {
    func setLayoutViews() {
        let margin: CGFloat = 20
        let spacing: CGFloat = 45
        
        addSubview(headerSectionView)
        headerSectionView.topAnchor(equalTo: safeTopAnchor, constant: margin)
        headerSectionView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        headerSectionView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(accountLoaderView)
        accountLoaderView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: spacing)
        accountLoaderView.centerXAnchor(equalTo: centerXAnchor)
        let animationSize = accountLoaderView.animationSize
        accountLoaderView.heightAnchor(equalTo: animationSize)
        accountLoaderView.widthAnchor(equalTo: animationSize)
        
        addSubview(statusDescriptionLabel)
        statusDescriptionLabel.topAnchor(equalTo: accountLoaderView.bottomAnchor, constant: spacing)
        statusDescriptionLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        statusDescriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
    }
}

// MARK: - Actions
extension FCAccountCreationView {
    private func showAlertToken() {
        let alert = UIAlertController(title: Constants.Texts.AccountSection.titleAlertToken, message: Constants.Texts.AccountSection.labelAlertToken, preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: Constants.Texts.AccountSection.titleButton, style: .default, handler: { (_: UIAlertAction) in
            if let textFields = alert.textFields {
                let textFieldToken = (textFields as [UITextField]).first
                let token = textFieldToken?.text
                self.credentialToken.token = token ?? ""
                self.credentialToken.id = self.accountViewModel.credentialId
                
                self.accountViewModel.updateCredentialToken(credentialToken: self.credentialToken)
            }
        })
        alert.addAction(action)
        
        let topVC = UIApplication.fcTopViewController()
        
        if let token = accountViewModel.token {
            alert.message = Constants.Texts.AccountSection.firstLabelAlertToken
            
            topVC?.present(alert, animated: true, completion: {
                            let margin: CGFloat = 5.0
            
                            let labelToken = UILabel(frame: CGRect(x: margin, y: 72.0, width: alert.view.frame.width - margin * 2.0, height: 20))
                            labelToken.text = token
                            labelToken.textAlignment = .center
                            labelToken.adjustsFontSizeToFitWidth = true
                            labelToken.minimumScaleFactor = 0.5
                            alert.view.addSubview(labelToken)
                        })
            return
        }
        topVC?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Observers View Model
extension FCAccountCreationView {
    private func observerServiceStatus() {
        accountViewModel.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
                        
            switch status {
            case .active, .loaded, .error: break
                
            case .success:
                self.trackEvent(eventName: Constants.Events.credentialSuccess)
                self.delegate?.accountCreationView(self,
                                                   onSuccess: .success,
                                                   bank: self.accountViewModel.bank)
                
            case .failure:
                self.trackEvent(eventName: Constants.Events.credentialFailure)
                self.delegate?.accountCreationView(self,
                                                   onFailure: .failure,
                                                   message: self.accountViewModel.errorMessage,
                                                   bank: self.accountViewModel.bank)
                
            case .updated:
                // The update gets called many times, this is to delegate only when credentialAccounts has items.
                if !self.accountViewModel.credentialAccounts.isEmpty {
                    let credentialAccount = self.accountViewModel.credentialAccounts.removeFirst()
                        self.delegate?.accountCreationView(self, accountCreated: credentialAccount)
                }
                
            case .interactive:
                self.showAlertToken()
                self.showCreationSteps()
            }
        }
    }
}
