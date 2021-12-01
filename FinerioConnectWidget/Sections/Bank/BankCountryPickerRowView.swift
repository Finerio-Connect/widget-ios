//
//  BankCountryPickerRowView.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 09/09/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

class BankCountryPickerRowView: UIView {
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
        label.textColor = .black
        return label
    }()

    private var country: Country!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(country: Country) {
        self.init(frame: .zero)

        self.country = country
        layoutViews()
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
        stackView.bottomAnchor(equalTo: bottomAnchor)
    }
}
