//
//  OnboardingCell.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 26/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingCell: UITableViewCell {
    // Components
    lazy var avatarView: UIImageView = setupAvatarView()
    lazy var descriptionLabel: UILabel = setupDescriptionLabel()
    
    // Vars
    static let cellIdentifier = "OnboardingCell"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .systemPink //.clear
        
        changeStyle()
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingCell {
    func setupLayoutViews() {
        addSubview(avatarView)
        avatarView.leadingAnchor(equalTo: leadingAnchor)
        avatarView.centerYAnchor(equalTo: centerYAnchor)
        
        addSubview(descriptionLabel)
        let spacing: CGFloat = 12
        descriptionLabel.leadingAnchor(equalTo: avatarView.trailingAnchor, constant: spacing)
        descriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        descriptionLabel.centerYAnchor(equalTo: centerYAnchor)
    }
    
    func setupAvatarView() -> UIImageView {
        let imageView = UIImageView(image: UIImage())
        let sizeView = CGFloat(33)
        imageView.heightAnchor(equalTo: sizeView)
        imageView.widthAnchor(equalTo: sizeView)
        imageView.layer.cornerRadius = sizeView / 2
        imageView.clipsToBounds = true
        return imageView
        
//        let avatarView = UIImageView(image: Images.buildingIcon.image())
//        let size: CGFloat = 12
//        avatarView.heightAnchor(equalTo: size)
//        avatarView.widthAnchor(equalTo: size)
//
//        let containerSize: CGFloat = 33
//        let roundedContainer = UIView()
//        roundedContainer.layer.cornerRadius = containerSize / 2
//        roundedContainer.backgroundColor = .white
//        roundedContainer.addSubview(avatarView)
//
//        roundedContainer.widthAnchor(equalTo: containerSize)
//        roundedContainer.heightAnchor(equalTo: containerSize)
//
//        avatarView.centerXAnchor(equalTo: roundedContainer.centerXAnchor)
//        avatarView.centerYAnchor(equalTo: roundedContainer.centerYAnchor)
//
//        return roundedContainer
    }
    
    func setCustomIconImage(_ image: UIImage) {
        let capInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        let resizedImg = image.resizableImage(withCapInsets: capInsets)
        avatarView.image = resizedImg
        avatarView.contentMode = .center
    }
    
    func setupDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14)
        label.text = literal(.onboardingMainDescription)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }
    
    func changeStyle() {
        #warning("PERZONALIZAR")
        let palette = Configuration.shared.palette
        avatarView.backgroundColor = palette.banksHeaderIconBackground.dynamicColor
    }
}
