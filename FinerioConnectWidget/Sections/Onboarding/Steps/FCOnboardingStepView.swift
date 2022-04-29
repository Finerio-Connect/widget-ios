//
//  OnboardingStepView.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 28/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class FCOnboardingStepView: FCBaseView {
    // Components
    private lazy var imageView:UIImageView = setupImageView()
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var descriptionLabel: VerticallyCenteredTextView = setupDescriptionLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()

    
    // Vars
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func configureView() {
        super.configureView()
        setLayoutViews()
        changeStyle()
    }
}

// MARK: - Layouts
extension FCOnboardingStepView {
    func setLayoutViews() {
        let margin: CGFloat = 20
        
        addSubview(imageView)
        imageView.topAnchor(equalTo: safeTopAnchor, constant: margin * 4)
        imageView.centerXAnchor(equalTo: centerXAnchor)
        
        addSubview(titleLabel)
        titleLabel.topAnchor(equalTo: imageView.bottomAnchor, constant: margin * 4)
        titleLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        titleLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: margin * 0.8)
        descriptionLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        descriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        let stackView = UIStackView(arrangedSubviews: [exitButton, continueButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.bottomAnchor(equalTo: safeBottomAnchor, constant: -margin * 4)
        stackView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        stackView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
    }
}

// MARK: - UI
extension FCOnboardingStepView {
    func setupImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = Images.stepLockIcon.image()
        let imageSize: CGFloat = 220
        imageView.widthAnchor(equalTo: imageSize)
        imageView.heightAnchor(equalTo: imageSize)
        return imageView
    }
    
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .fcMediumFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 16 : 18)
        label.text = "Completamente seguro"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }
    
    private func setupDescriptionLabel() -> VerticallyCenteredTextView {
        let textView = VerticallyCenteredTextView()
        let plainAttributes: [NSAttributedString.Key: Any]
        let linkAttributes: [NSAttributedString.Key : Any]
        
        let plainText = "Recuerda en ningún momento se realizarán movimientos o compras. Si tienes dudas de la privacidad puedes consultarlo aquí."//literal(plain)!
        let termsColor = Configuration.shared.palette.credentialsTermsPlainText.dynamicColor
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 10 : 12
        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
        
        plainAttributes = [.foregroundColor: termsColor, .font: fontType]
        let attributedString = NSMutableAttributedString(string: plainText,
                                                         attributes: plainAttributes)
        
        let linkedText = "aquí"//literal(.linked)!
        let linkRange = (attributedString.string as NSString).range(of: linkedText)
        
        let urlWebSite = "www.google.com" //Constants.URLS.termsAndConditions
        attributedString.addAttribute(NSAttributedString.Key.link, value: urlWebSite, range: linkRange)
        
        let linkColor = Configuration.shared.palette.credentialsTermsLinkedText.dynamicColor
        linkAttributes = [.foregroundColor: linkColor, .font: fontType]
        
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        textView.backgroundColor = .clear
        textView.linkTextAttributes = linkAttributes
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.textAlignment = .center
        return textView
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
        button.setTitle(literal(.onboardingStepContinueButton), for: .normal)
//        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingStepExitButton), for: .normal)
//        button.addTarget(self, action: #selector(didSelectExitButton), for: .touchUpInside)
        return button
    }
}

// MARK: - Style
extension FCOnboardingStepView {
    func changeStyle() {
        let palette = Configuration.shared.palette
        continueButton.backgroundColor = palette.accountStatusContinueButtonBackground.dynamicColor
        continueButton.setTitleColor(palette.accountStatusContinueButtonText.dynamicColor, for: .normal)
        exitButton.backgroundColor = palette.accountStatusExitButtonBackground.dynamicColor
        exitButton.setTitleColor(palette.accountStatusExitButtonText.dynamicColor, for: .normal)
    }
}
