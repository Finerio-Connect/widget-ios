//
//  Palette.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

final public class Palette: NSObject {
    #warning("BORRAR")
    public var mainColor: UIColor
    public var mainTextColor: UIColor
    public var mainSubTextColor: UIColor
    public var bankCellDetailColor: UIColor
    public var bankCellSeparatorColor: UIColor
    public var termsTextColor: UIColor
    public var borderTextField: UIColor
    public var grayBackgroundColor: UIColor
    
    #warning("TESTING")
    ///Banks section
    public var banksBackground: FCColor
    public var banksHeaderTitle: FCColor
    public var banksHeaderSubtitle: FCColor
    public var banksHeaderIcon: FCColor
    public var banksHeaderIconBackground: FCColor
    public var banksSelectCountryLabel: FCColor
    public var banksSelectedCountryName: FCColor
    public var banksSelectorFieldBackground: FCColor
    public var banksCountrySelectorArrow: FCColor
    public var banksCountryCellBackground: FCColor
    public var banksSelectorFieldBorder: FCColor
    public var banksSegmentedControlBackground: FCColor
    public var banksSegmentedControlActiveItem: FCColor
    public var banksSegmentedControlActiveText: FCColor
    public var banksSegmentedControlText: FCColor
    public var banksListCellBackground: FCColor
    public var banksListCellTitle: FCColor
    public var banksListCellSubtitle: FCColor
    public var banksListCellSeparator: FCColor
    public var banksCountryCellTitle: FCColor
    public var banksListCellDisclosureIndicator: FCColor
    
    
    
    

    public init(mainColor: UIColor = Colors.mainColor,
                mainTextColor: UIColor = Colors.mainTextColor,
                mainSubTextColor: UIColor = Colors.mainSubTextColor,
                bankCellDetailColor: UIColor = Colors.bankCellDetailTextColor,
                bankCellSeparatorColor: UIColor = Colors.bankCellSeparatorColor,
                termsTextColor: UIColor = Colors.termsTextColor,
                borderTextField: UIColor = Colors.borderTextField,
                grayBackgroundColor: UIColor = Colors.grayBackgroundColor
                
                ,banksBackground: FCColor = FCComponentsStyle.banksBackground
                ,banksHeaderTitle: FCColor = FCComponentsStyle.banksHeaderTitle
                ,banksHeaderSubtitle: FCColor = FCComponentsStyle.banksHeaderSubtitle
                ,banksHeaderIcon: FCColor = FCComponentsStyle.banksHeaderIcon
                ,banksHeaderIconBackground: FCColor = FCComponentsStyle.banksHeaderIconBackground
                ,banksSelectCountryLabel: FCColor = FCComponentsStyle.banksSelectCountryLabel
                ,banksSelectedCountryName: FCColor = FCComponentsStyle.banksSelectedCountryName
                ,banksSelectorFieldBackground: FCColor = FCComponentsStyle.banksSelectorFieldBackground
                ,banksCountrySelectorArrow: FCColor = FCComponentsStyle.banksCountrySelectorArrow
                ,banksCountryCellBackground: FCColor = FCComponentsStyle.banksCountryCellBackground
                ,banksSelectorFieldBorder: FCColor = FCComponentsStyle.banksSelectorFieldBorder
                ,banksSegmentedControlBackground: FCColor = FCComponentsStyle.banksSegmentedControlBackground
                ,banksSegmentedControlActiveItem: FCColor = FCComponentsStyle.banksSegmentedControlActiveItem
                ,banksSegmentedControlActiveText: FCColor = FCComponentsStyle.banksSegmentedControlActiveText
                ,banksSegmentedControlText: FCColor = FCComponentsStyle.banksSegmentedControlText
                ,banksListCellBackground: FCColor = FCComponentsStyle.banksListCellBackground
                ,banksListCellTitle: FCColor = FCComponentsStyle.banksListCellTitle
                ,banksListCellSubtitle: FCColor = FCComponentsStyle.banksListCellSubtitle
                ,banksListCellSeparator: FCColor = FCComponentsStyle.banksListCellSeparator
                ,banksCountryCellTitle: FCColor = FCComponentsStyle.banksCountryCellTitle
                ,banksListCellDisclosureIndicator: FCColor = FCComponentsStyle.banksListCellDisclosureIndicator
                
                
                
                
                
    ) {
        self.mainColor = mainColor
        self.mainTextColor = mainTextColor
        self.mainSubTextColor = mainSubTextColor
        self.bankCellDetailColor = bankCellDetailColor
        self.bankCellSeparatorColor = bankCellSeparatorColor
        self.termsTextColor = termsTextColor
        self.borderTextField = borderTextField
        self.grayBackgroundColor = grayBackgroundColor
        
        self.banksBackground = banksBackground
        self.banksHeaderTitle = banksHeaderTitle
        self.banksHeaderSubtitle = banksHeaderSubtitle
        self.banksHeaderIcon = banksHeaderIcon
        self.banksHeaderIconBackground = banksHeaderIconBackground
        self.banksSelectCountryLabel = banksSelectCountryLabel
        self.banksSelectedCountryName = banksSelectedCountryName
        self.banksSelectorFieldBackground = banksSelectorFieldBackground
        self.banksCountrySelectorArrow = banksCountrySelectorArrow
        self.banksCountryCellBackground = banksCountryCellBackground
        self.banksSelectorFieldBorder = banksSelectorFieldBorder
        self.banksSegmentedControlBackground = banksSegmentedControlBackground
        self.banksSegmentedControlActiveItem = banksSegmentedControlActiveItem
        self.banksSegmentedControlActiveText = banksSegmentedControlActiveText
        self.banksSegmentedControlText = banksSegmentedControlText
        self.banksListCellBackground = banksListCellBackground
        self.banksListCellTitle = banksListCellTitle
        self.banksListCellSubtitle = banksListCellSubtitle
        self.banksListCellSeparator = banksListCellSeparator
        self.banksCountryCellTitle = banksCountryCellTitle
        self.banksListCellDisclosureIndicator = banksListCellDisclosureIndicator
        
    }
}
