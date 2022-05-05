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

//extension FCComponentsStyle {
    // FINERIO GROUP
    //    private static let finerioBlue = FCColor(light: cetaceanBlue, dark: white)
    //    private static let finerioMint = FCColor(light: eucalyptus, dark: caribeanGreen)
    //    private static let finerioLightGray = FCColor(light: antiFlashWhite, dark: arsenic)
    //    private static let finerioWhite = FCColor(light: white, dark: darkGunMetal)
    //    private static let finerioLightText = FCColor(light: white, dark: white)
    //    private static let finerioContrastText = FCColor(light: americanBlue, dark: white)
    //    private static let finerioFailure = FCColor(light: lightSalmonPink, dark: lightSalmonPink)
    
    // SEMANTIC COLORS TO BE DELETED
    //    public static let publicPrimary = finerioBlue
    //    public static let publicSecondary = finerioLightGray
    //    public static let publicTint = finerioMint
    //    public static let publicBackground = finerioWhite
    //    public static let publicLightText = finerioLightText
    //    public static let publicContrastText = finerioContrastText
    //    public static let publicFailure = finerioFailure
    
    // BANKS SECTION
    //    public static let banksBackground = publicBackground
    //    public static let banksHeaderTitle = publicPrimary
    //    public static let banksHeaderSubtitle = publicPrimary
    //    public static let banksHeaderIcon = primary
    //    public static let banksHeaderIconBackground = FCColor(light: antiFlashWhite, dark: eerieBlack)
    //    public static let banksSelectCountryLabel = publicPrimary
    //    public static let banksSelectedCountryName = FCColor(light: manatee, dark: white)
    //    public static let banksSelectorFieldBackground = FCColor(light: white, dark: eerieBlack)
    //    public static let banksSelectorFieldBorder = FCColor(light: lightPeriwinkle, dark: eerieBlack)
    //    public static let banksCountrySelectorArrow = FCColor(light: manatee, dark: white)
    //    public static let banksCountryCellBackground = FCColor(light: white, dark: eerieBlack)
    //    public static let banksCountryCellTitle = FCColor(light: manatee, dark: white)
    
    //    public static let banksSegmentedControlActiveText = publicPrimary
    //    public static let banksSegmentedControlText = publicPrimary
    //    public static let banksListCellBackground = publicBackground
    //    public static let banksListCellTitle = publicPrimary
    //    public static let banksListCellSubtitle = FCColor(light: manatee, dark: white) // Hidden by now
    //    public static let banksListCellSeparator = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    //    public static let credentialsFieldsTextPlaceholder = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    //    static let genericDialogCloseButton = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    //    public static let banksListCellDisclosureIndicator = FCColor(light: manatee, dark: white)
    //    public static let credentialsFieldsIcon = FCColor(light: manatee, dark: white)
    //    public static let credentialsFieldsText = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsTermsPlainText = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsBannerIcon = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsBannerText = FCColor(light: darkBlueGray, dark: white)
    //    public static let accountStatusBodyText = FCColor(light: darkBlueGray, dark: white)
    
    
    
    
    // CREDENTIALS SECTION
    //    public static let credentialsBackground = publicBackground
    //    public static let credentialsHeaderTitle = publicPrimary
    //    public static let credentialsHeaderSubtitle = publicPrimary
    //    public static let credentialsFieldsTitle = publicContrastText
    //    public static let credentialsFieldsBorder = FCColor(light: lightPeriwinkle, dark: eerieBlack)
    //    public static let credentialsFieldsTextPlaceholder = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    //    public static let credentialsFieldsBackground = FCColor(light: white, dark: eerieBlack)
    //    public static let credentialsFieldsIcon = FCColor(light: manatee, dark: white)
    //    public static let credentialsFieldsText = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsSwitchOn = publicTint
    //    public static let credentialsTermsPlainText = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsTermsLinkedText = FCColor(light: cetateanBlue, dark: caribeanGreen)
    //    public static let credentialsContinueButtonBackground = accent
    //    public static let credentialsContinueButtonText = lightText
    //    public static let credentialsHelpButtonBackground = publicSecondary
    //    public static let credentialsHelpButtonText = publicContrastText
    //    public static let credentialsBannerBorder = publicTint
    //    public static let credentialsBannerIcon = FCColor(light: darkBlueGray, dark: white)
    //    public static let credentialsBannerText = FCColor(light: darkBlueGray, dark: white)
    
    // ACCOUNT CREATION SECTION
    //    public static let accountCreationBackground = publicBackground
    //    public static let accountCreationHeaderTitle = publicPrimary
    //    public static let accountCreationHeaderSubtitle = publicPrimary
    //    public static let accountCreationStatusText = publicPrimary
    
    // ACCOUNT STATUS SECTION
    //    public static let accountStatusBackground = publicBackground
    //    public static let accountStatusHeaderTitle = publicPrimary
    //    public static let accountStatusHeaderSubtitle = publicPrimary
    //    public static let accountStatusBodyText = FCColor(light: darkBlueGray, dark: white)
    //    public static let accountStatusSuccessIcon = publicTint
    //    public static let accountStatusFailureIcon = publicFailure
    //    public static let accountStatusContinueButtonBackground = accent
    //    public static let accountStatusExitButtonBackground = publicSecondary
    //    public static let accountStatusContinueButtonText = lightText
    //    public static let accountStatusExitButtonText = publicContrastText
    
    // STATUS BAR
    
    // GENERIC DIALOG
    //    static let genericDialogCloseButton = FCColor(light: lightPeriwinkle, dark: lightPeriwinkle)
    
    // EXTRA DATA DIALOG
    //    static let extraDialogAcceptButtonBackground = publicTint
    //    static let extraDialogAcceptButtonTitle = publicLightText
    //    static let extraDialogPickerText = publicContrastText
    //    static let extraDialogBackground = publicBackground
    //    static let extraDialogPickerSelectedItem = FCColor(light: antiFlashWhite, dark: eerieBlack) // NOT IN USE
    
    // ALL-IN-ONE FLOW VIEW CONTROLLERS
    //    public static let viewControllersAIOBackground = publicBackground
    
    // FULL LOADER VIEW
    //    static let fullLoaderViewBackground = publicBackground
//}
