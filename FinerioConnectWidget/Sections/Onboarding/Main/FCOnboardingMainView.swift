//
//  FCOnboardingMainView.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 25/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit
import CoreLocation

protocol FCOnboardingMainViewDelegate: AnyObject {
    func selectedContinueButton()
    func selectedExitButton()
}

class FCOnboardingMainView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var mainDescriptionLabel: UILabel = setupMainDescriptionLabel()
    private lazy var tableView: ContentSizedTableView = setupTableView()
    private lazy var linkedLabel: VerticallyCenteredTextView = setupLinkedLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    private lazy var exitButton: UIButton = setupExitButton()
    
    // Vars
    weak var delegate: FCOnboardingMainViewDelegate?
    private var main: OnboardingModel.Main!
    
    // Inits
    init(main: OnboardingModel.Main) {
        self.main = main
        super.init(frame: .zero)
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

// MARK: - Events
extension FCOnboardingMainView {
    @objc func didSelectContinueButton() {
        delegate?.selectedContinueButton()
    }
    
    @objc func didSelectExitButton() {
        delegate?.selectedExitButton()
    }
}

// MARK: - Layout
extension FCOnboardingMainView {
    func setLayoutViews() {
        let margin: CGFloat = 20
        let spacing: CGFloat = 45
        
        addSubview(headerSectionView)
        headerSectionView.topAnchor(equalTo: safeTopAnchor, constant: margin)
        headerSectionView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        headerSectionView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(mainDescriptionLabel)
        mainDescriptionLabel.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: spacing * 1.2)
        mainDescriptionLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        mainDescriptionLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(tableView)
        tableView.topAnchor(equalTo: mainDescriptionLabel.bottomAnchor, constant: margin)
        tableView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        tableView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        let stackView = UIStackView(arrangedSubviews: [continueButton, exitButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        addSubview(stackView)
        stackView.bottomAnchor(equalTo: safeBottomAnchor, constant: -spacing * 2)
        stackView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        stackView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(linkedLabel)
        linkedLabel.topAnchor(equalTo: tableView.bottomAnchor, constant: margin / 4)
        linkedLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        linkedLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        linkedLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
    }
}

// MARK: - UI
extension FCOnboardingMainView {
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.setCustomIconImage(Images.buildingIcon.image()!)
        headerView.titleLabel.text = main.headerTitle
        headerView.descriptionLabel.isHidden = true
        return headerView
    }
    
    private func setupMainDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14)
        label.text = main.headerDescription
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }
    
    private func setupTableView() -> ContentSizedTableView {
        let tableView = ContentSizedTableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OnboardingCell.self,
                           forCellReuseIdentifier: OnboardingCell.cellIdentifier)
        return tableView
    }
    
    private func setupLinkedLabel() -> VerticallyCenteredTextView {
        let textView = VerticallyCenteredTextView()
        let plainAttributes: [NSAttributedString.Key: Any]
        let linkAttributes: [NSAttributedString.Key : Any]
        
        let plainText = main.textWithLink.fullPlainText
        let termsColor = Configuration.shared.palette.credentialsTermsPlainText.dynamicColor
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14
        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
        
        plainAttributes = [.foregroundColor: termsColor, .font: fontType]
        let attributedString = NSMutableAttributedString(string: plainText,
                                                         attributes: plainAttributes)
        
        if let linkedText = main.textWithLink.linkedTextPhrase {
            let linkRange = (attributedString.string as NSString).range(of: linkedText)
            
            if let urlWebSite = main.textWithLink.urlSource {
                attributedString.addAttribute(NSAttributedString.Key.link, value: urlWebSite, range: linkRange)
            }
            
            let linkColor = Configuration.shared.palette.credentialsTermsLinkedText.dynamicColor
            linkAttributes = [
                .font: fontType,
                .underlineStyle: NSUnderlineStyle.thick.rawValue,
                .foregroundColor: linkColor
            ]
            
            textView.linkTextAttributes = linkAttributes
        }
        
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .left
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
        button.setTitle(literal(.onboardingMainContinueButton), for: .normal)
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        return button
    }
    
    private func setupExitButton() -> UIButton {
        let button = setupButton()
        button.setTitle(literal(.onboardingMainExitButton), for: .normal)
        button.addTarget(self, action: #selector(didSelectExitButton), for: .touchUpInside)
        return button
    }
}

// MARK: - TableView Data Source
extension FCOnboardingMainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return main.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var aCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingCell.cellIdentifier, for: indexPath) as? OnboardingCell {
            let listItem = main.listItems[indexPath.row]
            cell.descriptionLabel.text = listItem.description
            cell.setCustomIconImage(listItem.icon)
            aCell = cell
        }
        return aCell
    }
}

// MARK: - Style
extension FCOnboardingMainView {
    func changeStyle() {
#warning("PERSONALIZAR VARIABLES PARA COLOR ?")
        let palette = Configuration.shared.palette
        headerSectionView.avatarView.tintColor = palette.banksHeaderIcon.dynamicColor
        headerSectionView.avatarView.backgroundColor = palette.banksHeaderIconBackground.dynamicColor
        
        continueButton.backgroundColor = palette.accountStatusContinueButtonBackground.dynamicColor
        continueButton.setTitleColor(palette.accountStatusContinueButtonText.dynamicColor, for: .normal)
        exitButton.backgroundColor = palette.accountStatusExitButtonBackground.dynamicColor
        exitButton.setTitleColor(palette.accountStatusExitButtonText.dynamicColor, for: .normal)
        
    }
}