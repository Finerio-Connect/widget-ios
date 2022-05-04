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
        
        #warning("HARCODED COLOR")
//        self.backgroundColor = .green
        
        addSubview(imageView)
        imageView.topAnchor.constraint(lessThanOrEqualTo: safeTopAnchor, constant: margin * 5).isActive = true
        imageView.centerXAnchor(equalTo: centerXAnchor)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = margin
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        stackView.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: margin).isActive = true
        stackView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        stackView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        stackView.bottomAnchor(equalTo: bottomAnchor, constant: -margin)
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
        
        textView.attributedText = attributedString
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
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
