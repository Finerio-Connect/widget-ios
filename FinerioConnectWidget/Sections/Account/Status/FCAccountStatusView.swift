//
//  FCAccountStatusView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 10/12/21.
//

import Foundation
import UIKit

public protocol FCAccountStatusViewDelegate {
    func accountStatusView(didSelectContinueButton: UIButton)
    func accountStatusView(didSelectExitButton: UIButton)
}

public final class FCAccountStatusView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var statusAvatarView: UIImageView = setupStatusAvatarView()
    private lazy var bodyDescriptionLabel: UILabel = setupBodyDescriptionLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()
    
    // Vars
    public var delegate: FCAccountStatusViewDelegate?
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
        headerSectionView.titleLabel.text = literal(.bondingHeaderTitleFailure)
        headerSectionView.descriptionLabel.text = literal(.bondingHeaderSubtitleFailure)
        
        let statusImg = Images.failureIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = UIColor(hex: "#F89A9A")
        bodyDescriptionLabel.text = literal(.bondingDescriptionFailure)
        
        continueButton.setTitle(literal(.failureContinueTitleButton), for: .normal)
        exitButton.setTitle(literal(.failureExitTitleButton), for: .normal)
    }
    
    private func configureViewSuccess() {
        headerSectionView.titleLabel.text = literal(.bondingHeaderTitleSuccess)
        headerSectionView.descriptionLabel.text = literal(.bondingHeaderSubtitleSuccess)
        
        let statusImg = Images.successIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = Configuration.shared.palette.mainColor
        bodyDescriptionLabel.text = literal(.bondingDescriptionSuccess)
        
        continueButton.setTitle(literal(.successContinueTitleButton), for: .normal)
        exitButton.setTitle(literal(.successExitTitleButton), for: .normal)
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
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.backgroundColor = Configuration.shared.palette.grayBackgroundColor
        button.setTitleColor(Configuration.shared.palette.mainSubTextColor, for: .normal)
        button.addTarget(self, action: #selector(didSelectExitButton), for: .touchUpInside)
        return button
    }
}

// MARK: - Actions
extension FCAccountStatusView {
    @objc private func didSelectContinueButton() {
        delegate?.accountStatusView(didSelectContinueButton: continueButton)
    }
    
    @objc private func didSelectExitButton() {
        delegate?.accountStatusView(didSelectExitButton: exitButton)
    }
}

// MARK: - Layouts
extension FCAccountStatusView {
    private func setLayoutViews() {
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

