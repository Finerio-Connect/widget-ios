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
    public var backgroundColor: UIColor
    public var mainTextColor: UIColor
    public var termsTextColor: UIColor

    public init(mainColor: UIColor = Colors.mainColor,
                backgroundColor: UIColor = Colors.backgroundColor,
                mainTextColor: UIColor = Colors.mainTextColor,
                termsTextColor: UIColor = Colors.termsTextColor) {
        self.mainColor = mainColor
        self.backgroundColor = backgroundColor
        self.mainTextColor = mainTextColor
        self.termsTextColor = termsTextColor
    }
}
