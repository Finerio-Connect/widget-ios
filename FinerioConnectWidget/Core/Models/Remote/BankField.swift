//
//  BankField.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct BankField {
    public let name: String
    public let friendlyName: String
    public let position: Int
    public let type: String
    public let required: Bool
    public var value: String
}

extension BankField: JSONMappable {
    init?(json: NSDictionary) {
        guard let name = json["name"] as? String,
              let friendlyName = json["friendlyName"] as? String,
              let position = json["position"] as? Int,
              let type = json["type"] as? String,
              let required = json["required"] as? Bool else {
            return nil
        }

        self.name = name
        self.friendlyName = friendlyName
        self.position = position
        self.type = type
        self.required = required
        self.value = ""
    }
}
