//
//  BankCollectionViewCell.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class BankCollectionViewCell: UICollectionViewCell {
    static let id = "BankCollectionViewCell"

    lazy var bankImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(bankImageView)

        bankImageView.topAnchor(equalTo: topAnchor)
        bankImageView.bottomAnchor(equalTo: bottomAnchor)
        bankImageView.leadingAnchor(equalTo: leadingAnchor)
        bankImageView.trailingAnchor(equalTo: trailingAnchor)
    }

    func setup(with bank: Bank) {
        bankImageView.setImage(with: URL(string: Constants.URLS.bankImageOff.replacingOccurrences(of: Constants.Placeholders.bankId, with: bank.id)), defaultImage: Images.otherBanksOff.image())
    }
}
