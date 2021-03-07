//
//  CredentialStatus.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

public struct CredentialStatus {
    public let code: String
    public let message: String
    public let status: String
}

extension CredentialStatus: JSONMappable {
    init?(json: NSDictionary) {
        guard let code = json["code"] as? String,
              let message = json["message"] as? String,
              let status = json["status"] as? String else {
            return nil
        }

        self.code = code
        self.message = message
        self.status = status
    }
}
