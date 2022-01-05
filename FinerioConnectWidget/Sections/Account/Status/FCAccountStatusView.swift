//
//  FCAccountStatusView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 10/12/21.
//

import Foundation
import UIKit

class FCAccountStatusView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var statusAvatarView: UIImageView = setupStatusAvatarView()
    private lazy var bodyDescriptionLabel: UILabel = setupBodyDescriptionLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()
    
    // Vars
    private var accountStatusViewModel: AccountStatusViewModel = AccountStatusViewModel()
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func configureView() {
        super.configureView()
        addComponents()
        setLayoutViews()
    }
}

// MARK: - Data
extension FCAccountStatusView {
    public func setBank(_ bank: Bank) {
        self.accountStatusViewModel.bank = bank
        
        let imageName = Constants.URLS.bankImageShield.replacingOccurrences(of: Constants.Placeholders.bankCode,
                                                                            with: accountStatusViewModel.bank.code)
        let urlImage = URL(string: imageName)!
        headerSectionView.avatarView.setImage(with: urlImage,
                                              defaultImage: Images.otherBanksOff.image())
    }
    
    public func setStatus(_ status: ServiceStatus) {
        self.accountStatusViewModel.serviceStatus = status
        
        if status == .success {
            configureViewSuccess()
        } else {
            configureViewFailure()
        }
    }
}

// MARK: - Status Behaviour
extension FCAccountStatusView {
    private func configureViewFailure() {
        headerSectionView.titleLabel.text = Constants.Texts.StatusSection.failureTitleLabel
        headerSectionView.descriptionLabel.text = Constants.Texts.StatusSection.failureSubtitleLabel
        
        let statusImg = Images.failureIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = UIColor(hex: "#F89A9A")
        
        // Needs to handle the different message...(401,503,403)?
        bodyDescriptionLabel.text = Constants.Texts.StatusSection.failure401BodyDescriptionLabel
        
        continueButton.setTitle(Constants.Texts.StatusSection.failureContinueTitleButton, for: .normal)
        exitButton.setTitle(Constants.Texts.StatusSection.failureExitTitleButton, for: .normal)
    }
    
    private func configureViewSuccess() {
        headerSectionView.titleLabel.text = Constants.Texts.StatusSection.successTitleLabel
        headerSectionView.descriptionLabel.text = Constants.Texts.StatusSection.successSubtitleLabel
        
        let statusImg = Images.successIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = Configuration.shared.palette.mainColor
        
        bodyDescriptionLabel.text = Constants.Texts.StatusSection.successBodyDescriptionLabel
        
        continueButton.setTitle(Constants.Texts.StatusSection.successContinueTitleButton, for: .normal)
        exitButton.setTitle(Constants.Texts.StatusSection.successExitTitleButton, for: .normal)
    }
}

// MARK: - UI
extension FCAccountStatusView {
    private func addComponents() {
        addSubview(headerSectionView)
        addSubview(statusAvatarView)
        addSubview(bodyDescriptionLabel)
        addSubview(continueButton)
        addSubview(exitButton)
    }
    
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerSectionView = HeaderSectionView()
        return headerSectionView
    }
    
    private func setupStatusAvatarView() -> UIImageView {
        let imageView = UIImageView()
        let size: CGFloat = 60
        imageView.heightAnchor(equalTo: size)
        imageView.widthAnchor(equalTo: size)
        return imageView
    }
    
    private func setupBodyDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Configuration.shared.palette.termsTextColor
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        label.font = .fcRegularFont(ofSize: CGFloat(fontSize))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }
    
    private func setupButton() -> UIButton {
        let button = UIButton()
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        button.titleLabel?.font = .fcMediumFont(ofSize: fontSize)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.heightAnchor(equalTo: CGFloat(46))
        return button
    }
    
    private func setupContinueButton() -> UIButton {
        let button = setupButton()
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.addTarget(self, action: #selector(backToBanks), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.backgroundColor = Configuration.shared.palette.grayBackgroundColor
        button.setTitleColor(Configuration.shared.palette.mainSubTextColor, for: .normal)
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        return button
    }
}

// MARK: - Actions
extension FCAccountStatusView {
    @objc private func backToBanks() {
        let topVC = UIApplication.fcTopViewController()
        topVC?.navigationController?.navigationBar.isHidden = false
        topVC?.navigationController?.backToViewController(BankViewController.self)
    }
    
    @objc private func exit() {
        let topVC = UIApplication.fcTopViewController()
        topVC?.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Layouts
extension FCAccountStatusView {
    func setLayoutViews() {
        let margin: CGFloat = 20
        let spacing: CGFloat = 60
        // Header
        headerSectionView.topAnchor(equalTo: topAnchor, constant: margin)
        headerSectionView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        headerSectionView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        // Avatar
        statusAvatarView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: spacing)
        statusAvatarView.centerXAnchor(equalTo: centerXAnchor)
        // Description
        bodyDescriptionLabel.topAnchor(equalTo: statusAvatarView.bottomAnchor, constant: spacing)
        bodyDescriptionLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        bodyDescriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        // Button
        continueButton.topAnchor(equalTo: bodyDescriptionLabel.bottomAnchor, constant: spacing)
        continueButton.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        continueButton.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        // Button
        exitButton.topAnchor(equalTo: continueButton.bottomAnchor, constant: 8)
        exitButton.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        exitButton.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
    }
}

