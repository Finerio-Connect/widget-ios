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
        backgroundColor = .clear
        
        changeStyle()
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension OnboardingCell {
    func setupLayoutViews() {
        addSubview(avatarView)
        avatarView.topAnchor(equalTo: topAnchor, constant: 8)
        avatarView.leadingAnchor(equalTo: leadingAnchor)
        avatarView.centerYAnchor(equalTo: centerYAnchor)
        avatarView.bottomAnchor(equalTo: bottomAnchor, constant: -8)
        
        addSubview(descriptionLabel)
        let spacing: CGFloat = 12
        descriptionLabel.leadingAnchor(equalTo: avatarView.trailingAnchor, constant: spacing)
        descriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -spacing)
        descriptionLabel.centerYAnchor(equalTo: centerYAnchor)
    }
}

// MARK: - UI
extension OnboardingCell {
    func setupAvatarView() -> UIImageView {
        let imageView = UIImageView(image: UIImage())
        let sizeView = CGFloat(33)
        imageView.heightAnchor(equalTo: sizeView)
        imageView.widthAnchor(equalTo: sizeView)
        imageView.layer.cornerRadius = sizeView / 2
        imageView.clipsToBounds = true
        return imageView
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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        
        return label
    }
}

// MARK: - Style
extension OnboardingCell {
    func changeStyle() {
        let palette = Configuration.shared.palette
        avatarView.tintColor = palette.circleIconTint.dynamicColor
        avatarView.backgroundColor = palette.circleIconBackground.dynamicColor
        descriptionLabel.textColor = palette.regularSizedText.dynamicColor
    }
}
