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

    // Vars
    private var onboardingPage: OnboardingModel.Page!
    
    // Inits
    init(onboardingPage: OnboardingModel.Page) {
        self.onboardingPage = onboardingPage
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Methods
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
        
        self.backgroundColor = .green
        
        addSubview(imageView)
        imageView.topAnchor.constraint(greaterThanOrEqualTo: safeTopAnchor, constant: margin * 4).isActive = true
//        imageView.topAnchor(equalTo: safeTopAnchor, constant: margin * 4)
        imageView.centerXAnchor(equalTo: centerXAnchor)
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: margin).isActive = true
//        titleLabel.topAnchor(equalTo: imageView.bottomAnchor, constant: margin * 4)
        titleLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        titleLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: margin * 0.8)
        descriptionLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        descriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
//        descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -margin).isActive = true
        descriptionLabel.bottomAnchor(equalTo: bottomAnchor, constant: -margin)
    }
}

// MARK: - UI
extension FCOnboardingStepView {
    func setupImageView() -> UIImageView {
        let imageView = UIImageView()
        let imageSize: CGFloat = 220
        imageView.image = onboardingPage.image
        imageView.widthAnchor(equalTo: imageSize)
        imageView.heightAnchor(equalTo: imageSize)
        return imageView
    }
    
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .fcMediumFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 16 : 18)
        label.text = onboardingPage.title
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }
    
    private func setupDescriptionLabel() -> VerticallyCenteredTextView {
        let textView = VerticallyCenteredTextView()
        let plainAttributes: [NSAttributedString.Key: Any]
        let linkAttributes: [NSAttributedString.Key : Any]
        
        let plainText = onboardingPage.textWithLink.fullPlainText
        let termsColor = Configuration.shared.palette.credentialsTermsPlainText.dynamicColor
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14
        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
        
        plainAttributes = [.foregroundColor: termsColor, .font: fontType]
        let attributedString = NSMutableAttributedString(string: plainText,
                                                         attributes: plainAttributes)
        
        if let linkedText = onboardingPage.textWithLink.linkedTextPhrase {
            let linkRange = (attributedString.string as NSString).range(of: linkedText)
            
            if let urlWebSite = onboardingPage.textWithLink.urlSource {
                attributedString.addAttribute(NSAttributedString.Key.link, value: urlWebSite, range: linkRange)
            }
            
            let linkColor = Configuration.shared.palette.credentialsTermsLinkedText.dynamicColor
            linkAttributes = [.foregroundColor: linkColor, .font: fontType]
            
            textView.linkTextAttributes = linkAttributes
        }
        
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.textAlignment = .center
        return textView
    }    
}

// MARK: - Style
extension FCOnboardingStepView {
    func changeStyle() {
        let palette = Configuration.shared.palette
//        continueButton.backgroundColor = palette.accountStatusContinueButtonBackground.dynamicColor
//        continueButton.setTitleColor(palette.accountStatusContinueButtonText.dynamicColor, for: .normal)
//        exitButton.backgroundColor = palette.accountStatusExitButtonBackground.dynamicColor
//        exitButton.setTitleColor(palette.accountStatusExitButtonText.dynamicColor, for: .normal)
    }
}
