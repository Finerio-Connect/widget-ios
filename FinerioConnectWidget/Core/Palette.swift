//
//  Palette.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

final public class Palette: NSObject {
    public var mainColor: UIColor
    public var mainTextColor: UIColor
    public var mainSubTextColor: UIColor
    public var bankCellDetailColor: UIColor
    public var bankCellSeparatorColor: UIColor
    public var termsTextColor: UIColor
    public var borderTextField: UIColor
    public var grayBackgroundColor: UIColor

    public init(mainColor: UIColor = Colors.mainColor,
                mainTextColor: UIColor = Colors.mainTextColor,
                mainSubTextColor: UIColor = Colors.mainSubTextColor,
                bankCellDetailColor: UIColor = Colors.bankCellDetailTextColor,
                bankCellSeparatorColor: UIColor = Colors.bankCellSeparatorColor,
                termsTextColor: UIColor = Colors.termsTextColor,
                borderTextField: UIColor = Colors.borderTextField,
                grayBackgroundColor: UIColor = Colors.grayBackgroundColor) {
        self.mainColor = mainColor
        self.mainTextColor = mainTextColor
        self.mainSubTextColor = mainSubTextColor
        self.bankCellDetailColor = bankCellDetailColor
        self.bankCellSeparatorColor = bankCellSeparatorColor
        self.termsTextColor = termsTextColor
        self.borderTextField = borderTextField
        self.grayBackgroundColor = grayBackgroundColor
    }
}
