//
//  UIFont+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 06/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit
import Mixpanel

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
        return UIFont(name: Constants.Fonts.italicFont, size: size) ?? italicSystemFont(ofSize: size)
    }
    
    class func fcMediumFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: Constants.Fonts.mediumFont, size: size) ?? systemFont(ofSize: size, weight: .medium)
    }
}

// TO-DO: This can be improved
//extension UIFont {
//    enum LocalFont {
//        static let regular = "Poppins-Regular"
//        static let bold = "Poppins-Bold"
//        static let italic = "Poppins-Italic"
//        static let light = "Poppins-Light"
//        static let medium = "Poppins-Medium"
//    }
//    class func localRegularFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: LocalFont.regular, size: size) ?? .systemFont(ofSize: size)
//    }
//
//    class func localBoldFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: LocalFont.bold, size: size) ?? .boldSystemFont(ofSize: size)
//    }
//
//    class func localItalicFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: LocalFont.italic, size: size) ?? .italicSystemFont(ofSize: size)
//    }
//
//    class func localLightFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: LocalFont.light, size: size) ?? .systemFont(ofSize: size, weight: .light)
//    }
//
//    class func localMediumFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: LocalFont.medium, size: size) ?? .systemFont(ofSize: size, weight: .medium)
//    }
//}

extension UIFont {
    static func registerFonts(from bundle: Bundle) {
        logInfo("Registering local fonts...")
        let fontUrls = bundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil)!
        fontUrls.forEach { url in
            let fontDataProvider = CGDataProvider(url: url as CFURL)!
            let font = CGFont(fontDataProvider)!
            var error: Unmanaged<CFError>?
            guard CTFontManagerRegisterGraphicsFont(font, &error) else {
                fatalError("Could not register font from url \(url), error: \(error!.takeUnretainedValue())")
            }
        }
    }
}
