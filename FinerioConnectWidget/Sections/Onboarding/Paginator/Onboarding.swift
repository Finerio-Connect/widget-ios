//
//  OnboardingModel.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 02/05/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

public struct Onboarding {
    var main: Main
    var onboardingPages: [OnboardingPage]?
    
    public init (main: Main, pages: [OnboardingPage]? = nil) {
        self.main = main
        self.onboardingPages = pages
    }
}

// MARK: - Structs
public extension Onboarding {
    struct Main {
        var topIcon: UIImage
        var title: String
        var description: String
        var actionText: TextWithLink
        
        public init(icon: UIImage, title: String, description: String, actionText: TextWithLink) {
            self.topIcon = icon
            self.title = title
            self.description = description
            self.actionText = actionText
        }
    }
    
    struct OnboardingPage {
        var image: UIImage
        var icon: UIImage
        var title: String
        var detail: TextWithLink
        
        public init(image: UIImage, icon: UIImage, title: String, detail: TextWithLink) {
            self.image = image
            self.icon = icon
            self.title = title
            self.detail = detail
        }
    }
}
