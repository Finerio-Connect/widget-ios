//
//  Enums.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public enum ServiceStatus {
    case active
    case success
    case loaded
    case updated
    case failure
    case interactive
    case error
}

public enum Theme: Int {
    case automatic = 0
    case light = 1
    case dark = 2
}

enum FieldType: String {
    case text = "TEXT"
    case password = "PASSWORD"
    case select = "SELECT"
}

public enum LogLevel: Int {
    case none = 0
    case error = 1
    case info = 2
    case debug = 3
}

public enum Environment: String {
    case sandbox
    case production
}

public enum BankType: String, CaseIterable {
    case personal = "personal"
    case business = "business"
    case fiscal = "fiscal"
}
