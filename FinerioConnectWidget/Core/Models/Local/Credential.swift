//
//  Credential.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 18/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public final class Credential {
    public let widgetId: String
    public var customerName: String
    public var customerId: String?
    public var bankId: String?
    public let automaticFetching: Bool?
    public let state: String?
    public var username: String?
    public var password: String?
    public var securityCode: String?

    init(widgetId: String, customerName: String, customerId: String, bankId: String, automaticFetching: Bool, state: String, username: String, password: String, securityCode: String) {
        self.widgetId = widgetId
        self.customerId = customerId
        self.customerName = customerName
        self.bankId = bankId
        self.automaticFetching = automaticFetching
        self.state = HelperEncrypt().encrypted(state)
        self.username = username
        self.password = password
        self.securityCode = securityCode
    }

    init(widgetId: String, customerName: String, automaticFetching: Bool, state: String) {
        self.widgetId = widgetId
        self.customerName = customerName
        customerId = nil
        bankId = nil
        self.automaticFetching = automaticFetching
        self.state = HelperEncrypt().encrypted(state)
        username = nil
        password = nil
        securityCode = nil
    }
}
