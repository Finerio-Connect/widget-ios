//
//  SessionManager.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal final class SessionManager {
    static let shared = SessionManager()

    var banks: [Bank]?
}
