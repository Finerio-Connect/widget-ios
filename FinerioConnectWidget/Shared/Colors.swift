//
//  Colors.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

public struct Colors {
    public static let mainColor: UIColor = .green // UIColor(hex: "#3FD8AF")!
    public static let backgroundColor: UIColor = .green // UIColor(hex: "#FFFFFF")!
    public static let mainTextColor: UIColor = .green // UIColor(hex: "#00113D")!
    public static let mainSubTextColor: UIColor = .green // UIColor(hex: "#333F65")!
    public static let bankCellDetailTextColor: UIColor = .green // UIColor(hex: "#989DB3")!
    public static let bankCellSeparatorColor: UIColor = .green // UIColor(hex: "E3E5EB")!
    public static let termsTextColor: UIColor = .green // UIColor(hex: "#656E8D")!
    public static let borderTextField: UIColor = .green // UIColor(hex: "#CACDD9")!
    public static let grayBackgroundColor: UIColor = .green // UIColor(hex:"F1F2F5")!
}

public struct FCComponentsStyle {
    // BANKS SECTION
    public static let banksBackground = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#24252D")!)
    public static let banksHeaderTitle = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksHeaderSubtitle = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksHeaderIcon = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksHeaderIconBackground = FCColor(light: UIColor(hex: "#F1F2F5")!, dark: UIColor(hex: "#1B1A21")!)
    public static let banksSelectCountryLabel = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksSelectedCountryName = FCColor(light: UIColor(hex: "#989DB3")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksSelectorFieldBackground = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#1B1A21")!)
    public static let banksSelectorFieldBorder = FCColor(light: UIColor(hex: "#CACDD9")!, dark: UIColor(hex: "#1B1A21")!)
    public static let banksCountrySelectorArrow = FCColor(light: UIColor(hex: "#989DB3")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksCountryCellBackground = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#1B1A21")!)
    public static let banksCountryCellTitle = FCColor(light: UIColor(hex: "#989DB3")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksSegmentedControlBackground = FCColor(light: UIColor(hex: "#EEEEF0")!, dark: UIColor(hex: "#24252D")!)
    public static let banksSegmentedControlActiveItem = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#373946")!)
    public static let banksSegmentedControlActiveText = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksSegmentedControlText = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksListCellBackground = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#24252D")!)
    public static let banksListCellTitle = FCColor(light: UIColor(hex: "#00113D")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksListCellSubtitle = FCColor(light: UIColor(hex: "#989DB3")!, dark: UIColor(hex: "#FFFFFF")!)
    public static let banksListCellSeparator = FCColor(light: UIColor(hex: "#CACDD9")!, dark: UIColor(hex: "#CACDD9")!)
    public static let banksListCellDisclosureIndicator = FCColor(light: UIColor(hex: "#989DB3")!, dark: UIColor(hex: "#FFFFFF")!)
    
}

public struct FCColor {
    public let light: UIColor
    public let dark: UIColor?
    
    /// Gets the color according to the theme set by the contextual trait collection
    public var dynamicColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitcollection in
                if traitcollection.userInterfaceStyle == .dark {
                    return self.dark ?? self.light
                } else {
                    return self.light
                }
            }
        } else {
            // Fallback on earlier versions
            return self.light
        }
    }
    
    public init(light: UIColor, dark: UIColor?) {
        self.light = light
        self.dark = dark
    }
}
