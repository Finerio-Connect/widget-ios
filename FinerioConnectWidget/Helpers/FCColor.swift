//
//  FCColor.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 09/02/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

public struct FCColor {
    public let light: UIColor
    public let dark: UIColor?
    
    /// Gets the color according to the theme set by the contextual trait collection
    public var dynamicColor: UIColor {
        let theme = Configuration.shared.theme
        switch theme {
        case .automatic:
            if #available(iOS 13.0, *) {
                return UIColor { traitcollection in
                    if traitcollection.userInterfaceStyle == .dark {
                        return self.dark ?? self.light
                    } else {
                        return self.light
                    }
                }
            } else {
                // Fallback on earlier versions
                return self.light
            }
            
        case .light:
            return self.light
            
        case .dark:
            return self.dark ?? self.light
        }
    }
    
//    /// Gets the color according to the theme set by the contextual trait collection
//    public var dynamicColor: UIColor {
//        if #available(iOS 13.0, *) {
//            return UIColor { traitcollection in
//                if traitcollection.userInterfaceStyle == .dark {
//                    return self.dark ?? self.light
//                } else {
//                    return self.light
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//            return self.light
//        }
//    }
    
    public init(light: UIColor, dark: UIColor?) {
        self.light = light
        self.dark = dark
    }
}
