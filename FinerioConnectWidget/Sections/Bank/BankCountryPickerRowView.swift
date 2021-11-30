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
        countryImage.widthAnchor(equalTo: 30)
        countryImage.heightAnchor(equalTo: 30)
        
        countryLabel.text = country.name
        
        let views = [countryImage, countryLabel]
        let innerStackView = UIStackView(arrangedSubviews: views)
        innerStackView.axis = .horizontal
        innerStackView.alignment = .center
        innerStackView.distribution = .fill
        innerStackView.spacing = 8
        innerStackView.layer.borderWidth = 1
        innerStackView.layer.borderColor = UIColor.blue.cgColor
        
        let mainStackView = UIStackView(arrangedSubviews: [innerStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.layer.borderWidth = 1
        mainStackView.layer.borderColor = UIColor.red.cgColor
        
        addSubview(mainStackView)
        mainStackView.topAnchor(equalTo: topAnchor)
        mainStackView.leadingAnchor(equalTo: leadingAnchor)
        mainStackView.trailingAnchor(equalTo: trailingAnchor)
        mainStackView.bottomAnchor(equalTo: bottomAnchor)

//        [countryImage, countryLabel].forEach {
//            addSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
//
//        countryImage.leadingAnchor(equalTo: leadingAnchor, constant: 20)
//        countryImage.centerYAnchor(equalTo: centerYAnchor)
//        countryImage.widthAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 30 : 40)
//
//        countryLabel.leadingAnchor(equalTo: countryImage.trailingAnchor, constant: 20)
//        countryLabel.trailingAnchor(equalTo: trailingAnchor, constant: -20)
//        countryLabel.centerYAnchor(equalTo: centerYAnchor)
    }
}
