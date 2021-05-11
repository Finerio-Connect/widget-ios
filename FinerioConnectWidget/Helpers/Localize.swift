//
//  Localize.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

public func localize(_ key: String) -> String {
    return NSLocalizedString(key, tableName: nil, bundle: Bundle.finerioConnectWidget(), value: "", comment: "")
}
