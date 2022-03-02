//
//  FCBannerImageView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 06/12/21.
//

import UIKit

class FCBannerImageView: UIView {
    // Components
    lazy var imageView = setupImageView()
    lazy var bannerLabel = setupBannerLabel()
    lazy var bannerImageView = setupBannerImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {
        addSubview(bannerImageView)
        bannerImageView.topAnchor(equalTo: topAnchor)
        bannerImageView.leadingAnchor(equalTo: leadingAnchor)
        bannerImageView.trailingAnchor(equalTo: trailingAnchor)
        bannerImageView.bottomAnchor(equalTo: bottomAnchor)
        
        bannerImageView.addSubview(imageView)
        imageView.centerYAnchor(equalTo: bannerImageView.centerYAnchor)
        imageView.leadingAnchor(equalTo: bannerImageView.leadingAnchor, constant: 30)
        
        bannerImageView.addSubview(bannerLabel)
        bannerLabel.centerYAnchor(equalTo: imageView.centerYAnchor)
        bannerLabel.leadingAnchor(equalTo: imageView.trailingAnchor, constant: 8)
        bannerLabel.trailingAnchor(equalTo: bannerImageView.trailingAnchor, constant: -30)
        
        changeStyle()
    }
}

extension FCBannerImageView {
    func setupImageView() -> UIImageView {
        let lockImageView = UIImageView(image: Images.lockIcon.image())
        lockImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        lockImageView.heightAnchor(equalTo: 15)
        lockImageView.widthAnchor(equalTo: 15)
        return lockImageView
    }
    
    func setupBannerLabel() -> UILabel {
        let bannerLabel = UILabel()
        bannerLabel.text = literal(.credentialsDisclaimerText)
        bannerLabel.numberOfLines = 0
        bannerLabel.lineBreakMode = .byWordWrapping
        let fontSize = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 10 : 12
        bannerLabel.font = .fcMediumFont(ofSize: CGFloat(fontSize))
        return bannerLabel
    }
    
    func setupBannerMainStack() -> UIStackView {
        let bannerStack = UIStackView()
        bannerStack.axis = .horizontal
        bannerStack.alignment = .center
        bannerStack.spacing = 8
        return bannerStack
    }
    
    func setupBannerImageView() -> UIImageView {
        let tapeBannerImg = Images.tapeBanner.image()
        let imageView = UIImageView(image: tapeBannerImg)
        return imageView
    }
}

// MARK: - Style
extension FCBannerImageView {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        bannerImageView.tintColor = palette.credentialsBannerBorder.dynamicColor
        bannerLabel.textColor = palette.credentialsBannerText.dynamicColor
        imageView.tintColor = palette.credentialsBannerIcon.dynamicColor
    }
}
