//
//  UIAlertController+Extensions.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 23/02/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    @available(iOS 13.0, *)
    func setTheme(_ theme: Theme) {
        switch theme {
        case .automatic:
            self.overrideUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle
        case .light:
            self.overrideUserInterfaceStyle = .light
        case .dark:
            self.overrideUserInterfaceStyle = .dark
        }
    }
}
