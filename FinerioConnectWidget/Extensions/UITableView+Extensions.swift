//
//  UITableView+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/09/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = Configuration.shared.palette.mainTextColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .fcBoldFont(ofSize: 15)
        messageLabel.sizeToFit()

        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }
}
