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
    func selectedLinkedText()
}

class FCOnboardingMainView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var mainDescriptionLabel: UILabel = setupMainDescriptionLabel()
    private lazy var tableView: ContentSizedTableView = setupTableView()
    private lazy var linkedButton: UIButton = setupLinkedButton()
//    private lazy var linkedLabel: VerticallyCenteredTextView = setupLinkedLabel()
    private lazy var continueButton: UIButton = setupContinueButton()
    
    // Vars
    weak var delegate: FCOnboardingMainViewDelegate?
    private var onboardingModel: Onboarding!
    
    // Inits
    init(onboarding: Onboarding) {
        self.onboardingModel = onboarding
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
    
    @objc func didTapLinkedButton() {
        delegate?.selectedLinkedText()
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
        
//        addSubview(linkedLabel)
//        linkedLabel.topAnchor(equalTo: tableView.bottomAnchor, constant: margin / 4)
//        linkedLabel.leadingAnchor(equalTo: leadingAnchor, constant: margin)
//        linkedLabel.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
//        linkedLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
//
        let stackView = UIStackView(arrangedSubviews: [continueButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        addSubview(linkedButton)
        linkedButton.topAnchor(equalTo: tableView.bottomAnchor, constant: margin)
        linkedButton.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        linkedButton.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        addSubview(stackView)
        stackView.topAnchor.constraint(greaterThanOrEqualTo: linkedButton.bottomAnchor, constant: margin).isActive = true
        stackView.bottomAnchor(equalTo: safeBottomAnchor, constant: -spacing * 2)
        stackView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        stackView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)

    }
}

// MARK: - UI
extension FCOnboardingMainView {
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.setCustomIconImage(onboardingModel.main.topIcon)
        headerView.titleLabel.text = onboardingModel.main.title
        headerView.descriptionLabel.isHidden = true
        return headerView
    }
    
    private func setupMainDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14)
        label.text = onboardingModel.main.description
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
    
    private func setupLinkedButton() -> UIButton {
        let button = UIButton()
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14
        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
        let linkColor = Configuration.shared.palette.linkedText.dynamicColor
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: fontType,
            .foregroundColor: linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedString = NSMutableAttributedString(string: onboardingModel.main.actionText.fullPlainText,
                                                         attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapLinkedButton), for: .touchUpInside)
        return button
    }
    
//    private func setupLinkedLabel() -> VerticallyCenteredTextView {
//        let textView = VerticallyCenteredTextView()
//        let plainAttributes: [NSAttributedString.Key: Any]
//        let linkAttributes: [NSAttributedString.Key : Any]
//
//        let plainText = main.textWithLink.fullPlainText
//        let termsColor = Configuration.shared.palette.liteText.dynamicColor
//        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 14
//        let fontType = UIFont.fcRegularFont(ofSize: fontSize)
//
//        plainAttributes = [.foregroundColor: termsColor, .font: fontType]
//        let attributedString = NSMutableAttributedString(string: plainText,
//                                                         attributes: plainAttributes)
//
//        if let linkedText = main.textWithLink.linkedTextPhrase {
//            let linkRange = (attributedString.string as NSString).range(of: linkedText)
//
//            if let urlWebSite = main.textWithLink.urlSource {
//                attributedString.addAttribute(NSAttributedString.Key.link, value: urlWebSite, range: linkRange)
//            }
//
//            let linkColor = Configuration.shared.palette.linkedText.dynamicColor
//            linkAttributes = [
//                .font: fontType,
//                .underlineStyle: NSUnderlineStyle.thick.rawValue,
//                .foregroundColor: linkColor
//            ]
//
//            textView.linkTextAttributes = linkAttributes
//        }
//
//        textView.backgroundColor = .clear
//        textView.attributedText = attributedString
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        textView.textAlignment = .left
//        return textView
//    }
    
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
}

// MARK: - TableView Data Source
extension FCOnboardingMainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onboardingModel.onboardingPages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var aCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingCell.cellIdentifier, for: indexPath) as? OnboardingCell {
            if let page = onboardingModel.onboardingPages?[indexPath.row] {
                cell.descriptionLabel.text = page.title
                cell.setCustomIconImage(page.icon)
            }
            aCell = cell
        }
        return aCell
    }
}

// MARK: - Style
extension FCOnboardingMainView {
    func changeStyle() {
        let palette = Configuration.shared.palette
        headerSectionView.titleLabel.textColor = palette.mediumSizedText.dynamicColor
        headerSectionView.avatarView.tintColor = palette.circleIconTint.dynamicColor
        headerSectionView.avatarView.backgroundColor = palette.circleIconBackground.dynamicColor
        mainDescriptionLabel.textColor = palette.regularSizedText.dynamicColor
        continueButton.backgroundColor = palette.buttonActiveBackground.dynamicColor
        continueButton.setTitleColor(palette.buttonActiveText.dynamicColor, for: .normal)
    }
}
