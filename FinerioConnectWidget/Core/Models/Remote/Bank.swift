//
//  Bank.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct Bank {
    public let id: String
    public let name: String
    public let code: String
    public let status: String
}

extension Bank: JSONMappable {
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String,
              let code = json["code"] as? String,
              let status = json["status"] as? String else {
            return nil
        }

        guard status == "ACTIVE" || status == "PARTIALLY_ACTIVE" else { return nil }

        self.id = String(id)
        self.name = name
        self.code = code
        self.status = status
    }
}
