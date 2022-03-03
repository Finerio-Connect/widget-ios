//
//  UIDevice+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 25/11/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit.UIDevice

internal extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case iPhone_13Pro = "iPhone 13 Pro"
        case iPhone_13ProMax = "iPhone 13 Pro Max"
        case unknown
    }

    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2532:
            return .iPhone_13Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        case 2778:
            return .iPhone_13ProMax
        default:
            return .unknown
        }
    }
}
