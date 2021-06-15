//
//  UIFont+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 06/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

internal extension UIFont {
    class func fcLighFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Constants.Fonts.lighFont, size: size) ?? .systemFont(ofSize: size, weight: .light)
    }

    class func fcRegularFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Constants.Fonts.regularFont, size: size) ?? .systemFont(ofSize: size)
    }

    class func fcBoldFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Constants.Fonts.boldFont, size: size) ?? .boldSystemFont(ofSize: size)
    }

    class func fcItalicFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Constants.Fonts.italicFont, size: size) ?? .italicSystemFont(ofSize: size)
    }
}
