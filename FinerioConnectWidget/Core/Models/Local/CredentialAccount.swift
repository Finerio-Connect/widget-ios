//
//  CredentialAccount.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 15/12/21.
//

import Foundation

public final class CredentialAccount {
    var credentialId: String
    var accountId: String
    var name: String
    var status: String
    
    init(credentialId: String, accountId: String, name: String, status: String) {
        self.credentialId = credentialId
        self.accountId = accountId
        self.name = name
        self.status = status
    }
}
