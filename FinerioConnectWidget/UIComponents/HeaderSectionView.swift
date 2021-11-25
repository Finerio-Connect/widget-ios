//
//  HeaderSectionView.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 18/11/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

class HeaderSectionView: UIView {
    // Components
    lazy var avatarView: UIImageView = setupAvatarView()
    lazy var titleLabel: UILabel = setupTitleLabel()
    lazy var descriptionLabel: UILabel = setupDescriptionLabel()
    private lazy var mainStack: UIStackView = setupMainStack()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}

extension HeaderSectionView {
    private func setupView() {
        addSubview(mainStack)
        // AVATAR
        mainStack.addArrangedSubview(avatarView)
        // LABELS
        let labels = [titleLabel, descriptionLabel]
        let labelsStack = UIStackView(arrangedSubviews: labels)
        labelsStack.axis = .vertical
        labelsStack.alignment = .center
        labelsStack.spacing = 4
        mainStack.addArrangedSubview(labelsStack)
        
        setLayoutForMainStack()
    }
    
    private func setLayoutForMainStack() -> Void {
        mainStack.topAnchor(equalTo: topAnchor)
        mainStack.leadingAnchor(equalTo: leadingAnchor)
        mainStack.trailingAnchor(equalTo: trailingAnchor)
        mainStack.bottomAnchor(equalTo: bottomAnchor)
    }
    
    private func setupAvatarView() -> UIImageView {
        let imageView = UIImageView(image: UIImage())
        let sizeView = CGFloat(33)
        imageView.heightAnchor(equalTo: sizeView)
        imageView.widthAnchor(equalTo: sizeView)
        imageView.layer.cornerRadius = sizeView / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(hex: "#F1F2F5")
        
        return imageView
    }
    
    func setLockAvatarView() {
        let lockIconImage = Images.lockIcon.image()!
        let capInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        let resizedImg = lockIconImage.resizableImage(withCapInsets: capInsets)
        avatarView.image = resizedImg
        avatarView.contentMode = .center
        avatarView.tintColor = Configuration.shared.palette.mainTextColor
    }
    
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16
        label.font = .fcBoldFont(ofSize: CGFloat(fontSize))
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }
    
    private func setupDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        label.font = .fcRegularFont(ofSize: CGFloat(fontSize))
        label.textColor = Configuration.shared.palette.mainSubTextColor
        return label
    }
    
    private func setupMainStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }
}
