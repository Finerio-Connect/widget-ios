//
//  BankTableViewCell.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 16/11/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {
    // Components
    lazy var avatarView: UIImageView = setupAvatarView()
    lazy var lblTitle: UILabel = setupLabelTitle()
    lazy var lblSubtitle: UILabel = setupLabelSubtitle()
    // Vars
    static let cellIdentifier = "BankTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        let disclosureIndicator = UIImageView(image: Images.disclosureIndicator.image())
        disclosureIndicator.frame = CGRect(x: 0, y: 0, width: 6, height: 12)
        accessoryView = disclosureIndicator
        
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutViews() {
        let labelsStack = UIStackView(arrangedSubviews: [lblTitle])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        
        let mainStack = UIStackView(arrangedSubviews: [avatarView, labelsStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 13
        mainStack.alignment = .center
        mainStack.distribution = .fillProportionally
        
        contentView.addSubview(mainStack)
        let topBottomSpacing = CGFloat(16)
        mainStack.topAnchor(equalTo: contentView.topAnchor, constant: topBottomSpacing)
        mainStack.leadingAnchor(equalTo: contentView.leadingAnchor)
        mainStack.trailingAnchor(equalTo: contentView.trailingAnchor)
        mainStack.bottomAnchor(equalTo: contentView.bottomAnchor, constant: -topBottomSpacing)
    }
}

// MARK: - Data
extension BankTableViewCell {
    func setup(with bank: Bank) {
        avatarView.setImage(with: URL(string: Constants.URLS.bankImageShield.replacingOccurrences(of: Constants.Placeholders.bankCode, with: bank.code)), defaultImage: Images.otherBanksOff.image())
        
        lblTitle.text = bank.name
        lblSubtitle.text = bank.code
    }
}

// MARK: - UI
extension BankTableViewCell {
    private func setupAvatarView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        let avatarSize = CGFloat(33)
        imageView.heightAnchor(equalTo: avatarSize)
        imageView.widthAnchor(equalTo: avatarSize)
        imageView.layer.cornerRadius = avatarSize / 2
        return imageView
    }
    
    private func setupLabelTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .fcMediumFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 10 : 12)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }
    
    private func setupLabelSubtitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = .fcMediumFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 8 : 10)
        label.textColor = Configuration.shared.palette.bankCellDetailColor
        return label
    }
}

// MARK: - Style
extension BankTableViewCell {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        didChangeStyle()
    }
    
    private func didChangeStyle() {
        let palette = Configuration.shared.palette
        backgroundColor = palette.banksListCellBackground.dynamicColor
        lblTitle.textColor = palette.banksListCellTitle.dynamicColor
//        lblSubtitle.textColor = palette.banksListCellSubtitle.dynamicColor
        accessoryView?.tintColor = palette.banksListCellDisclosureIndicator.dynamicColor
    }
}
