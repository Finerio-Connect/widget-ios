//
//  HelperEncrypt.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 18/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import SwiftyRSA

final internal class HelperEncrypt {
    func encrypted(_ message: String) -> String {
        let publicKey = try! PublicKey(pemEncoded: Constants.Keys.publicKey)
        let clear = try! ClearMessage(string: message, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)

        return encrypted.base64String
    }
}
