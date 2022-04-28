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
    lazy var imageView:UIImageView = setupImageView()
    lazy var titleLabel: UILabel = setupTitleLabel()
    
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
}

// MARK: - Style
extension FCOnboardingStepView {
    func changeStyle() {
        
    }
}
