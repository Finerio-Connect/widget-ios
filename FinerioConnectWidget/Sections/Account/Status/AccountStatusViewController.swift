//
//  AccountStatusViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit

internal class AccountStatusViewController: BaseViewController {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var statusAvatarView: UIImageView = setupStatusAvatarView()
    private lazy var bodyDescriptionLabel: UILabel = setupBodyDescriptionLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()
    private lazy var mainStack: UIStackView = setupMainStack()
    // Vars
    private var accountStatusViewModel: AccountStatusViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountStatusViewModel = viewModel as? AccountStatusViewModel
        configureView()
    }
    
    private func configureView() {
        title = accountStatusViewModel.getTitle()
        
        headerSectionView.titleLabel.text = Constants.Texts.StatusSection.successTitleLabel
        headerSectionView.descriptionLabel.text = Constants.Texts.StatusSection.successSubtitleLabel
        mainStack.addArrangedSubview(headerSectionView)
        
        let statusImg = Images.successIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = Configuration.shared.palette.mainColor
        
        let statusImgStack = UIStackView(arrangedSubviews: [statusAvatarView])
        statusImgStack.axis = .vertical
        statusImgStack.alignment = .center
        mainStack.addArrangedSubview(statusImgStack)
        
        bodyDescriptionLabel.text = Constants.Texts.StatusSection.successBodyDescriptionLabel
        mainStack.addArrangedSubview(bodyDescriptionLabel)
        
        continueButton.setTitle(Constants.Texts.StatusSection.successContinueTitleButton, for: .normal)
        exitButton.setTitle(Constants.Texts.StatusSection.successExitTitleButton, for: .normal)
        
        let buttons = [continueButton, exitButton]
        let buttonsStack = UIStackView(arrangedSubviews: buttons)
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 8
        mainStack.addArrangedSubview(buttonsStack)
        
        view.addSubview(mainStack)
        mainStack.topAnchor(equalTo: view.safeTopAnchor, constant: 20)
        mainStack.leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
        mainStack.trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
    }
    
    private func configureViewFailure() {
        title = accountStatusViewModel.getTitle()
        
        headerSectionView.titleLabel.text = Constants.Texts.StatusSection.failureTitleLabel
        headerSectionView.descriptionLabel.text = Constants.Texts.StatusSection.failureSubtitleLabel
        mainStack.addArrangedSubview(headerSectionView)
        
        let statusImg = Images.failureIcon.image()
        statusAvatarView.image = statusImg
        statusAvatarView.tintColor = UIColor(hex: "#F89A9A")
        
        let statusImgStack = UIStackView(arrangedSubviews: [statusAvatarView])
        statusImgStack.axis = .vertical
        statusImgStack.alignment = .center
        mainStack.addArrangedSubview(statusImgStack)
        
        // Needs to handle the different message...(401,503,403)
        bodyDescriptionLabel.text = Constants.Texts.StatusSection.failure401BodyDescriptionLabel
        mainStack.addArrangedSubview(bodyDescriptionLabel)
        
        continueButton.setTitle(Constants.Texts.StatusSection.failureContinueTitleButton, for: .normal)
        exitButton.setTitle(Constants.Texts.StatusSection.failureExitTitleButton, for: .normal)
        
        let buttons = [continueButton, exitButton]
        let buttonsStack = UIStackView(arrangedSubviews: buttons)
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 8
        mainStack.addArrangedSubview(buttonsStack)
        
        view.addSubview(mainStack)
        mainStack.topAnchor(equalTo: view.safeTopAnchor, constant: 20)
        mainStack.leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
        mainStack.trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
    }
}

// MARK: - UI

extension AccountStatusViewController {
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerSectionView = HeaderSectionView()
        let imageName = Constants.URLS.bankImageShield.replacingOccurrences(of: Constants.Placeholders.bankCode,
                                                                            with: accountStatusViewModel.bank.code)
        let urlImage = URL(string: imageName)!
        headerSectionView.avatarView.setImage(with: urlImage,
                                              defaultImage: Images.otherBanksOff.image())
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
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16
        label.font = .fcRegularFont(ofSize: CGFloat(fontSize))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }
    
    private func setupButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .fcRegularFont(ofSize: 18)
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
    
    private func setupMainStack() -> UIStackView {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 70
        return mainStack
    }
}

// MARK: - Actions

extension AccountStatusViewController {
    @objc private func backToBanks() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.backToViewController(BankViewController.self)
    }
    
    @objc private func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}
