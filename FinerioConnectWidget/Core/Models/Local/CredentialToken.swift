//
//  CredentialToken.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 21/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

final public class CredentialToken {
    public var id: String?
    public var token: String?
    public let widgetId: String

    init(widgetId: String, id: String? = nil, token: String? = nil) {
        self.id = id
        self.widgetId = widgetId
        self.token = token
    }
}
