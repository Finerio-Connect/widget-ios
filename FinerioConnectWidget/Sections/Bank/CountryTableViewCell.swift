//
//  CountryTableViewCell.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 20/01/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

class CountryTableViewCell: UITableViewCell {
    lazy var countryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        let imageSize: CGFloat =  UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 30 : 40
        image.widthAnchor(equalTo: imageSize)
        image.heightAnchor(equalTo: imageSize)
        return image
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .fcRegularFont(ofSize: 15)
        return label
    }()
    
    private var country: Country!
    static let cellIdentifier = "CountryCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setCountry(_ country: Country) {
        self.country = country
        layoutViews()
        changeStyle()
    }
    
    private func layoutViews() {
        backgroundColor = .clear
        countryImage.setImage(with: URL(string: country.imageUrl))
        countryLabel.text = country.name
        
        let views = [countryImage, countryLabel]
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        
        addSubview(stackView)
        let sideSpacing: CGFloat = 20
        stackView.topAnchor(equalTo: topAnchor)
        stackView.leadingAnchor(equalTo: leadingAnchor, constant: sideSpacing)
        stackView.trailingAnchor(equalTo: trailingAnchor, constant: -sideSpacing)
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        stackView.bottomAnchor(equalTo: bottomAnchor)
    }
}

// MARK: - Style
extension CountryTableViewCell {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        backgroundColor = palette.banksCountryCellBackground.dynamicColor
        countryLabel.textColor = palette.banksCountryCellTitle.dynamicColor
    }
}
