//
//  Enums.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

enum ServiceStatus {
    case active
    case success
    case loaded
    case updated
    case failure
    case interactive
}

enum FieldType: String {
    case text = "TEXT"
    case password = "PASSWORD"
    case securityCode = "SECURITYCODE"
}
