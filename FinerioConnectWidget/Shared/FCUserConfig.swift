//
//  FCUserConfig.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 07/05/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation

struct UserConfig {
    static private let defaults = UserDefaults.standard
    
    private enum Keys: String {
        case hasShownOnboarding
    }
    
    static var hasShownOnboarding: Bool {
        get { return defaults.bool(forKey: Keys.hasShownOnboarding.rawValue) }
        set { defaults.set(newValue, forKey: Keys.hasShownOnboarding.rawValue) }
    }
}
