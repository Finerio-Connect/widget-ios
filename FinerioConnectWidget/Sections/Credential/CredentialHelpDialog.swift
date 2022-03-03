//
//  CredentialHelpDialog.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 09/09/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialHelpDialog: GenericDialog {
    private lazy var helpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public var imageURL: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.helpImageView.setImage(with: URL(string: self.imageURL))
            }
        }
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        containerView.addSubview(helpImageView)
        helpImageView.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 25)
        helpImageView.topAnchor(equalTo: containerView.topAnchor, constant: 25)
        helpImageView.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -25)
        helpImageView.bottomAnchor(equalTo: containerView.bottomAnchor, constant: -25)
    }
}
