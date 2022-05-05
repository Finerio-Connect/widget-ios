//
//  Palette.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

final public class Palette: NSObject {
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
    public var pageDotActive: FCColor
    public var pageDotInactive: FCColor
    
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
        ,pageDotActive: FCColor = FCComponentsStyle.pageDotActive
        ,pageDotInactive: FCColor = FCComponentsStyle.pageDotInactive
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
        self.pageDotActive = pageDotActive
        self.pageDotInactive = pageDotInactive
    }
}
