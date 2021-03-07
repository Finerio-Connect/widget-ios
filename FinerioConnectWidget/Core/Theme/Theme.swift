//
//  Theme.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

public class Theme: NSObject {
    public static let defaultTheme = Theme()

    public static func `default`() -> Theme {
        return Theme.defaultTheme
    }

    // MARK: - Instance Properties

    public var mainColor: UIColor
    public var backgroundColor: UIColor
    public var mainTextColor: UIColor
    public var termsTextColor: UIColor
    public var font: UIFont
    public var lightFont: UIFont
    // public var barStyle: UIBarStyle

    // MARK: - Initializer

    public init(mainColor: UIColor = Colors.mainColor,
                backgroundColor: UIColor = Colors.backgroundColor,
                mainTextColor: UIColor = Colors.mainTextColor,
                termsTextColor: UIColor = Colors.termsTextColor,
                font: UIFont = Colors.font,
                lightFont: UIFont = Colors.lightFont) {
        self.mainColor = mainColor
        self.backgroundColor = backgroundColor
        self.mainTextColor = mainTextColor
        self.termsTextColor = termsTextColor
        self.font = font
        self.lightFont = lightFont
    }
}
