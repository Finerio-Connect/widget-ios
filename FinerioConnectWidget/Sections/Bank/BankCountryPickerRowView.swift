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

        [countryImage, countryLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        countryImage.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        countryImage.centerYAnchor(equalTo: centerYAnchor)
        countryImage.widthAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 30 : 40)

        countryLabel.leadingAnchor(equalTo: countryImage.trailingAnchor, constant: 20)
        countryLabel.trailingAnchor(equalTo: trailingAnchor, constant: -20)
        countryLabel.centerYAnchor(equalTo: centerYAnchor)
    }
}
