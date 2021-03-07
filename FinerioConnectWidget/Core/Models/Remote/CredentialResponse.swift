//
//  CredentialResponse.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 22/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct CredentialResponse {
    public let username: String
    public let id: String
    public let status: String
    public let automaticFetching: Bool
    public let dateCreated: Int
}

extension CredentialResponse: JSONMappable {
    init?(json: NSDictionary) {
        guard let username = json["username"] as? String,
              let id = json["id"] as? String,
              let status = json["status"] as? String,
              let automaticFetching = json["automaticFetching"] as? Bool,
              let dateCreated = json["dateCreated"] as? Int else {
            return nil
        }

        self.username = username
        self.id = id
        self.status = status
        self.automaticFetching = automaticFetching
        self.dateCreated = dateCreated
    }
}
