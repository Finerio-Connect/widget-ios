//
//  FCComponentsStyle.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

private extension FCComponentsStyle {
    // LIGHT THEME
    private static let cetaceanBlue = UIColor(hex: "#00113D")!
    private static let americanBlue = UIColor(hex: "#333F65")!
    private static let eucalyptus = UIColor(hex: "#3FD8AF")!
    private static let antiFlashWhite = UIColor(hex: "#F1F2F5")!
    private static let manatee = UIColor(hex: "#989DB3")!
    private static let lightPeriwinkle = UIColor(hex: "#CACDD9")!
    private static let brightGray = UIColor(hex: "#EEEEF0")!
    private static let darkBlueGray = UIColor(hex: "#656E8D")!
    private static let lightSalmonPink = UIColor(hex: "#F89A9A")!
    // DARK THEME
    private static let white = UIColor(hex: "#FFFFFF")!
    private static let caribeanGreen = UIColor(hex: "#07CEA4")!
    private static let arsenic = UIColor(hex: "#373946")!
    private static let darkGunMetal = UIColor(hex: "#24252D")!
    private static let eerieBlack = UIColor(hex: "#1B1A21")!
}

public struct FCComponentsStyle {
    // BY COMPONENTS
    public static var circleIconTint = FCColor(light: cetaceanBlue, dark: white)
    public static var circleIconBackground = FCColor(light: antiFlashWhite, dark: eerieBlack)
    public static var buttonActiveBackground = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var buttonActiveText = FCColor(light: white, dark: white)
    public static var buttonPassiveBackground = FCColor(light: antiFlashWhite, dark: arsenic)
    public static var buttonPassiveText = FCColor(light: americanBlue, dark: white)
    public static var backgroundView = FCColor(light: white, dark: darkGunMetal)
    public static var regularSizedText = FCColor(light: americanBlue, dark: white)
    public static var mediumSizedText = FCColor(light: cetaceanBlue, dark: white)
    public static var liteText = FCColor(light: darkBlueGray, dark: white)
    public static var linkedText = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var fieldsBackground = FCColor(light: white, dark: eerieBlack)
    public static var fieldsBorder = FCColor(light: lightPeriwinkle, dark: eerieBlack)
    public static var fieldsPlaceholder = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static var fieldsRightIcon = FCColor(light: manatee, dark: white)
    public static var segmentedControlBackground = FCColor(light: brightGray, dark: eerieBlack)
    public static var segmentedControlActiveItem = FCColor(light: white, dark: arsenic)
    public static var dropDownMenuTint = FCColor(light: manatee, dark: white)
    public static var toggleSwitchOn = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var bannerBorder = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var successIconTint = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var failureIconTint = FCColor(light: lightSalmonPink, dark: lightSalmonPink)
    public static var statusBarBackground = FCColor(light: .clear, dark: .clear)
    public static var cellSeparator = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static var cellDisclosureIndicator = FCColor(light: manatee, dark: white)
    public static var dialogCloseButton = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static var pageDotActive = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static var pageDotInactive = FCColor(light: lightPeriwinkle, dark: eerieBlack)

    public static var zendeskIconBackground = FCColor(light: UIColor(hex: "#3FD8AF")!, dark: UIColor(hex: "#07CEA4")!)
    public static var zendeskIconTint = FCColor(light: UIColor(hex: "#FFFFFF")!, dark: UIColor(hex: "#000000")!)
}
