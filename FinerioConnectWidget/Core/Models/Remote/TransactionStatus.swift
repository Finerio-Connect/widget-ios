//
//  AccountStatus.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 12/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

final internal class AccountStatus {
    public let id: String
    public let name: String
    public var status: String
    public var loaded: Bool = false

    init(id: String, name: String, status: String) {
        self.id = id
        self.name = name
        self.status = status
    }
}
