//
//  CountryModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/09/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct Country {
    public let code: String
    public let name: String
    public let imageUrl: String
}

extension Country: JSONMappable {
    init?(json: NSDictionary) {
        guard let code = json["code"] as? String,
              let name = json["name"] as? String,
              let imageUrl = json["imageUrl"] as? String else {
            return nil
        }

        self.code = code
        self.name = name
        self.imageUrl = imageUrl
    }
}
