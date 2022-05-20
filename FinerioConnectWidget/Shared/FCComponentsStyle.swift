//
//  FCComponentsStyle.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

public struct FCComponentsStyle {
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

extension FCComponentsStyle {
    // BY COMPONENTS
    public static let circleIconTint = FCColor(light: cetaceanBlue, dark: white)
    public static let circleIconBackground = FCColor(light: antiFlashWhite, dark: eerieBlack)
    public static let buttonActiveBackground = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let buttonActiveText = FCColor(light: white, dark: white)
    public static let buttonPassiveBackground = FCColor(light: antiFlashWhite, dark: arsenic)
    public static let buttonPassiveText = FCColor(light: americanBlue, dark: white)
    public static let backgroundView = FCColor(light: white, dark: darkGunMetal)
    public static let regularSizedText = FCColor(light: americanBlue, dark: white)
    public static let mediumSizedText = FCColor(light: cetaceanBlue, dark: white)
    public static let liteText = FCColor(light: darkBlueGray, dark: white)
    public static let linkedText = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let fieldsBackground = FCColor(light: white, dark: eerieBlack)
    public static let fieldsBorder = FCColor(light: lightPeriwinkle, dark: eerieBlack)
    public static let fieldsPlaceholder = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static let fieldsRightIcon = FCColor(light: manatee, dark: white)
    public static let segmentedControlBackground = FCColor(light: brightGray, dark: eerieBlack)
    public static let segmentedControlActiveItem = FCColor(light: white, dark: arsenic)
    public static let dropDownMenuTint = FCColor(light: manatee, dark: white)
    public static let toggleSwitchOn = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let bannerBorder = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let successIconTint = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let failureIconTint = FCColor(light: lightSalmonPink, dark: lightSalmonPink)
    public static let statusBarBackground = FCColor(light: .clear, dark: .clear)
    public static let cellSeparator = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static let cellDisclosureIndicator = FCColor(light: manatee, dark: white)
    public static let dialogCloseButton = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    public static let pageDotActive = FCColor(light: eucalyptus, dark: caribeanGreen)
    public static let pageDotInactive = FCColor(light: lightPeriwinkle, dark: eerieBlack)
}
