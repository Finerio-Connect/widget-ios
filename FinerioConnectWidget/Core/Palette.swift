//
//  Palette.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

final public class Palette: NSObject {
    /// NEWS General
    public var circleIconTint: FCColor
    public var circleIconBackground: FCColor
    public var buttonActiveBackground: FCColor
    public var buttonActiveText: FCColor
    public var buttonPassiveBackground: FCColor
    public var buttonPassiveText: FCColor
    public var linkedText: FCColor
    public var backgroundView: FCColor
    public var regularSizedText: FCColor
    public var mediumSizedText: FCColor
    public var fieldsBackground: FCColor
    public var fieldsBorder: FCColor
    public var fieldsPlaceholder: FCColor
    public var fieldsRightIcon: FCColor
    public var segmentedControlBackground: FCColor
    public var segmentedControlActiveItem: FCColor
    public var dropDownMenuTint: FCColor
    public var toggleSwitchOn: FCColor
    public var bannerBorder: FCColor
    public var successIconTint: FCColor
    public var failureIconTint: FCColor
    public var statusBarBackground: FCColor
    public var liteText: FCColor
    public var cellSeparator: FCColor
    public var cellDisclosureIndicator: FCColor
    public var dialogCloseButton: FCColor
    
    
    
    
    
    
    // OLDS
    ///Banks section
//    public var banksBackground: FCColor
//    public var banksHeaderTitle: FCColor
//    public var banksHeaderSubtitle: FCColor
//    public var banksHeaderIcon: FCColor
//    public var banksHeaderIconBackground: FCColor
//    public var banksSelectCountryLabel: FCColor
//    public var banksSelectedCountryName: FCColor
//    public var banksSelectorFieldBackground: FCColor
//    public var banksCountrySelectorArrow: FCColor
//    public var banksCountryCellBackground: FCColor
//    public var banksSelectorFieldBorder: FCColor
//    public var banksSegmentedControlBackground: FCColor
//    public var banksSegmentedControlActiveItem: FCColor
//    public var banksSegmentedControlActiveText: FCColor
//    public var banksSegmentedControlText: FCColor
//    public var banksListCellBackground: FCColor
//    public var banksListCellTitle: FCColor
    //    public var banksListCellSubtitle: FCColor // Hidden by now
//    public var banksListCellSeparator: FCColor
//    public var banksCountryCellTitle: FCColor
//    public var banksListCellDisclosureIndicator: FCColor
    
    /// Credentials section
//    public var credentialsBackground: FCColor
//    public var credentialsHeaderTitle: FCColor
//    public var credentialsHeaderSubtitle: FCColor
//    public var credentialsFieldsTitle: FCColor
//    public var credentialsFieldsBorder: FCColor
//    public var credentialsFieldsTextPlaceholder: FCColor
//    public var credentialsFieldsBackground: FCColor
//    public var credentialsFieldsIcon: FCColor
//    public var credentialsFieldsText: FCColor
//    public var credentialsSwitchOn: FCColor
//    public var credentialsTermsPlainText: FCColor
//    public var credentialsTermsLinkedText: FCColor
//    public var credentialsContinueButtonBackground: FCColor
//    public var credentialsContinueButtonText: FCColor
//    public var credentialsHelpButtonBackground: FCColor
//    public var credentialsHelpButtonText: FCColor
//    public var credentialsBannerBorder: FCColor
//    public var credentialsBannerIcon: FCColor
//    public var credentialsBannerText: FCColor
    
    ///Account creation
//    public var accountCreationBackground: FCColor
//    public var accountCreationHeaderTitle: FCColor
//    public var accountCreationHeaderSubtitle: FCColor
//    public var accountCreationStatusText: FCColor
    
    /// Account status
//    public var accountStatusBackground: FCColor
//    public var accountStatusHeaderTitle: FCColor
//    public var accountStatusHeaderSubtitle: FCColor
//    public var accountStatusBodyText: FCColor
//    public var accountStatusSuccessIcon: FCColor
//    public var accountStatusFailureIcon: FCColor
//    public var accountStatusContinueButtonBackground: FCColor
//    public var accountStatusExitButtonBackground: FCColor
//    public var accountStatusContinueButtonText: FCColor
//    public var accountStatusExitButtonText: FCColor
    
    /// Status bar
    
    ///AIO ViewController
//    public var viewControllersAIOBackground: FCColor
    
    
    public init(
        circleIconTint: FCColor = FCComponentsStyle.circleIconTint
        ,circleIconBackground: FCColor = FCComponentsStyle.circleIconBackground
        ,buttonActiveBackground: FCColor = FCComponentsStyle.buttonActiveBackground
        ,buttonActiveText: FCColor = FCComponentsStyle.buttonActiveText
        ,buttonPassiveBackground: FCColor = FCComponentsStyle.buttonPassiveBackground
        ,buttonPassiveText: FCColor = FCComponentsStyle.buttonPassiveText
        ,backgroundView: FCColor = FCComponentsStyle.backgroundView
        ,regularSizedText: FCColor = FCComponentsStyle.regularSizedText
        ,mediumSizedText: FCColor = FCComponentsStyle.mediumSizedText
        ,linkedText: FCColor = FCComponentsStyle.linkedText
        ,fieldsBackground: FCColor = FCComponentsStyle.fieldsBackground
        ,fieldsBorder: FCColor = FCComponentsStyle.fieldsBorder
        ,fieldsRightIcon: FCColor = FCComponentsStyle.fieldsRightIcon
        ,segmentedControlBackground: FCColor = FCComponentsStyle.segmentedControlBackground
        ,segmentedControlActiveItem: FCColor = FCComponentsStyle.segmentedControlActiveItem
        ,dropDownMenuTint: FCColor = FCComponentsStyle.dropDownMenuTint
        ,toggleSwitchOn: FCColor = FCComponentsStyle.toggleSwitchOn
        ,bannerBorder: FCColor = FCComponentsStyle.bannerBorder
        ,successIconTint: FCColor = FCComponentsStyle.successIconTint
        ,failureIconTint: FCColor = FCComponentsStyle.failureIconTint
        ,statusBarBackground: FCColor = FCComponentsStyle.statusBarBackground
        ,liteText: FCColor = FCComponentsStyle.liteText
        ,cellSeparator: FCColor = FCComponentsStyle.cellSeparator
        ,cellDisclosureIndicator: FCColor = FCComponentsStyle.cellDisclosureIndicator
        ,fieldsPlaceholder: FCColor = FCComponentsStyle.fieldsPlaceholder
        ,dialogCloseButton: FCColor = FCComponentsStyle.dialogCloseButton
        
        
//        ,banksBackground: FCColor = FCComponentsStyle.banksBackground
//        ,banksHeaderTitle: FCColor = FCComponentsStyle.banksHeaderTitle
//        ,banksHeaderSubtitle: FCColor = FCComponentsStyle.banksHeaderSubtitle
//        ,banksHeaderIcon: FCColor = FCComponentsStyle.banksHeaderIcon
//        ,banksHeaderIconBackground: FCColor = FCComponentsStyle.banksHeaderIconBackground
//        ,banksSelectCountryLabel: FCColor = FCComponentsStyle.banksSelectCountryLabel
//        ,banksSelectedCountryName: FCColor = FCComponentsStyle.banksSelectedCountryName
//        ,banksSelectorFieldBackground: FCColor = FCComponentsStyle.banksSelectorFieldBackground
//        ,banksCountrySelectorArrow: FCColor = FCComponentsStyle.banksCountrySelectorArrow
//        ,banksCountryCellBackground: FCColor = FCComponentsStyle.banksCountryCellBackground
//        ,banksSelectorFieldBorder: FCColor = FCComponentsStyle.banksSelectorFieldBorder
//        ,banksSegmentedControlBackground: FCColor = FCComponentsStyle.segmentedControlBackground
//        ,banksSegmentedControlActiveItem: FCColor = FCComponentsStyle.segmentedControlActiveItem
//        ,banksSegmentedControlActiveText: FCColor = FCComponentsStyle.banksSegmentedControlActiveText
//        ,banksSegmentedControlText: FCColor = FCComponentsStyle.banksSegmentedControlText
//        ,banksListCellBackground: FCColor = FCComponentsStyle.banksListCellBackground
//        ,banksListCellTitle: FCColor = FCComponentsStyle.banksListCellTitle
        //                ,banksListCellSubtitle: FCColor = FCComponentsStyle.banksListCellSubtitle
//        ,banksListCellSeparator: FCColor = FCComponentsStyle.banksListCellSeparator
//        ,banksCountryCellTitle: FCColor = FCComponentsStyle.banksCountryCellTitle
//        ,banksListCellDisclosureIndicator: FCColor = FCComponentsStyle.banksListCellDisclosureIndicator
        
//        ,credentialsBackground: FCColor = FCComponentsStyle.credentialsBackground
//        ,credentialsHeaderTitle: FCColor = FCComponentsStyle.credentialsHeaderTitle
//        ,credentialsHeaderSubtitle: FCColor = FCComponentsStyle.credentialsHeaderSubtitle
//        ,credentialsFieldsTitle: FCColor = FCComponentsStyle.credentialsFieldsTitle
//        ,credentialsFieldsBorder: FCColor = FCComponentsStyle.credentialsFieldsBorder
//        ,credentialsFieldsTextPlaceholder: FCColor = FCComponentsStyle.credentialsFieldsTextPlaceholder
//        ,credentialsFieldsBackground: FCColor = FCComponentsStyle.credentialsFieldsBackground
//        ,credentialsFieldsIcon: FCColor = FCComponentsStyle.credentialsFieldsIcon
//        ,credentialsFieldsText: FCColor = FCComponentsStyle.credentialsFieldsText
//        ,credentialsSwitchOn: FCColor = FCComponentsStyle.credentialsSwitchOn
//        ,credentialsTermsPlainText: FCColor = FCComponentsStyle.credentialsTermsPlainText
//        ,credentialsTermsLinkedText: FCColor = FCComponentsStyle.credentialsTermsLinkedText
//        ,credentialsContinueButtonBackground: FCColor = FCComponentsStyle.credentialsContinueButtonBackground
//        ,credentialsContinueButtonText: FCColor = FCComponentsStyle.credentialsContinueButtonText
//        ,credentialsHelpButtonBackground: FCColor = FCComponentsStyle.credentialsHelpButtonBackground
//        ,credentialsHelpButtonText: FCColor = FCComponentsStyle.credentialsHelpButtonText
//        ,credentialsBannerBorder: FCColor = FCComponentsStyle.credentialsBannerBorder
//        ,credentialsBannerIcon: FCColor = FCComponentsStyle.credentialsBannerIcon
//        ,credentialsBannerText: FCColor = FCComponentsStyle.credentialsBannerText
        
//        ,accountCreationBackground: FCColor = FCComponentsStyle.accountCreationBackground
//        ,accountCreationHeaderTitle: FCColor = FCComponentsStyle.accountCreationHeaderTitle
//        ,accountCreationHeaderSubtitle: FCColor = FCComponentsStyle.accountCreationHeaderSubtitle
//        ,accountCreationStatusText: FCColor = FCComponentsStyle.accountCreationStatusText
        
//        ,accountStatusBackground: FCColor = FCComponentsStyle.accountStatusBackground
//        ,accountStatusHeaderTitle: FCColor = FCComponentsStyle.accountStatusHeaderTitle
//        ,accountStatusHeaderSubtitle: FCColor = FCComponentsStyle.accountStatusHeaderSubtitle
        
//        ,accountStatusBodyText: FCColor = FCComponentsStyle.accountStatusBodyText
//        ,accountStatusSuccessIcon: FCColor = FCComponentsStyle.accountStatusSuccessIcon
//        ,accountStatusFailureIcon: FCColor = FCComponentsStyle.accountStatusFailureIcon
//        ,accountStatusContinueButtonBackground: FCColor = FCComponentsStyle.accountStatusContinueButtonBackground
//        ,accountStatusExitButtonBackground: FCColor = FCComponentsStyle.accountStatusExitButtonBackground
//        ,accountStatusContinueButtonText: FCColor = FCComponentsStyle.accountStatusContinueButtonText
//        ,accountStatusExitButtonText: FCColor = FCComponentsStyle.accountStatusExitButtonText
        
//        ,viewControllersAIOBackground: FCColor = FCComponentsStyle.viewControllersAIOBackground
    ) {
        self.circleIconTint = circleIconTint
        self.circleIconBackground = circleIconBackground
        self.buttonActiveBackground = buttonActiveBackground
        self.buttonActiveText = buttonActiveText
        self.buttonPassiveBackground = buttonPassiveBackground
        self.buttonPassiveText = buttonPassiveText
        self.backgroundView = backgroundView
        self.linkedText = linkedText
        self.regularSizedText = regularSizedText
        self.mediumSizedText = mediumSizedText
        self.fieldsBackground = fieldsBackground
        self.fieldsBorder = fieldsBorder
        self.fieldsPlaceholder = fieldsPlaceholder
        self.fieldsRightIcon = fieldsRightIcon
        self.segmentedControlBackground = segmentedControlBackground
        self.segmentedControlActiveItem = segmentedControlActiveItem
        self.dropDownMenuTint = dropDownMenuTint
        self.toggleSwitchOn = toggleSwitchOn
        self.bannerBorder = bannerBorder
        self.successIconTint = successIconTint
        self.failureIconTint = failureIconTint
        self.statusBarBackground = statusBarBackground
        self.liteText = liteText
        self.cellSeparator = cellSeparator
        self.cellDisclosureIndicator = cellDisclosureIndicator
        self.dialogCloseButton = dialogCloseButton
        
        
        
//        self.banksBackground = banksBackground
//        self.banksHeaderTitle = banksHeaderTitle
//        self.banksHeaderSubtitle = banksHeaderSubtitle
//        self.banksHeaderIcon = banksHeaderIcon
//        self.banksHeaderIconBackground = banksHeaderIconBackground
//        self.banksSelectCountryLabel = banksSelectCountryLabel
//        self.banksSelectedCountryName = banksSelectedCountryName
//        self.banksSelectorFieldBackground = banksSelectorFieldBackground
//        self.banksCountrySelectorArrow = banksCountrySelectorArrow
//        self.banksCountryCellBackground = banksCountryCellBackground
//        self.banksSelectorFieldBorder = banksSelectorFieldBorder
//        self.credentialsFieldsTextPlaceholder = credentialsFieldsTextPlaceholder

//        self.banksSegmentedControlActiveText = banksSegmentedControlActiveText
//        self.banksSegmentedControlText = banksSegmentedControlText
//        self.banksListCellBackground = banksListCellBackground
//        self.banksListCellTitle = banksListCellTitle
        //        self.banksListCellSubtitle = banksListCellSubtitle
//        self.banksListCellSeparator = banksListCellSeparator
//        self.banksCountryCellTitle = banksCountryCellTitle
//        self.banksListCellDisclosureIndicator = banksListCellDisclosureIndicator
        
//        self.credentialsBackground = credentialsBackground
//        self.credentialsHeaderTitle = credentialsHeaderTitle
//        self.credentialsHeaderSubtitle = credentialsHeaderSubtitle
//        self.credentialsFieldsTitle = credentialsFieldsTitle
//        self.credentialsFieldsBorder = credentialsFieldsBorder
//        self.credentialsFieldsBackground = credentialsFieldsBackground
//        self.credentialsFieldsIcon = credentialsFieldsIcon
//        self.credentialsFieldsText = credentialsFieldsText
//        self.credentialsSwitchOn = credentialsSwitchOn
//        self.credentialsTermsPlainText = credentialsTermsPlainText
//        self.credentialsTermsLinkedText = credentialsTermsLinkedText
//        self.credentialsContinueButtonBackground = credentialsContinueButtonBackground
//        self.credentialsContinueButtonText = credentialsContinueButtonText
//        self.credentialsHelpButtonBackground = credentialsHelpButtonBackground
//        self.credentialsHelpButtonText = credentialsHelpButtonText
//        self.credentialsBannerBorder = credentialsBannerBorder
//        self.credentialsBannerIcon = credentialsBannerIcon
//        self.credentialsBannerText = credentialsBannerText
        
//        self.accountCreationBackground = accountCreationBackground
//        self.accountCreationHeaderTitle = accountCreationHeaderTitle
//        self.accountCreationHeaderSubtitle = accountCreationHeaderSubtitle
//        self.accountCreationStatusText = accountCreationStatusText
        
//        self.accountStatusBackground = accountStatusBackground
//        self.accountStatusHeaderTitle = accountStatusHeaderTitle
//        self.accountStatusHeaderSubtitle = accountStatusHeaderSubtitle
        
//        self.accountStatusBodyText = accountStatusBodyText
//        self.accountStatusSuccessIcon = accountStatusSuccessIcon
//        self.accountStatusFailureIcon = accountStatusFailureIcon
//        self.accountStatusContinueButtonBackground = accountStatusContinueButtonBackground
//        self.accountStatusExitButtonBackground = accountStatusExitButtonBackground
//        self.accountStatusContinueButtonText = accountStatusContinueButtonText
//        self.accountStatusExitButtonText = accountStatusExitButtonText
        
//        self.viewControllersAIOBackground = viewControllersAIOBackground
    }
}
