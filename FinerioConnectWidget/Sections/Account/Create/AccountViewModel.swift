//
//  AccountViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import FirebaseDatabase
import UIKit

internal class AccountViewModel {
    var errorMessage: String!
    var token: String!
    var credentialId: String!
    var accounts: [AccountStatus] = []
    var credentialAccounts: [CredentialAccount] = []
    var transactionsCreated: Bool = false
    var bank: Bank!

    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }
    let databaseReference = Database.database().reference()

    func updateCredentialToken(credentialToken: CredentialToken) {
        FinerioConnectWidgetAPI.updateCredentialToken(credentialToken: credentialToken) { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }
        }
    }

    func firebaseObserver() {
        DispatchQueue.main.async {
            self.databaseReference.child(Constants.Keys.firebaseNode).child(self.credentialId).observe(.value, with: { [self] snapshot in
                if let values = snapshot.value as? [String: Any] {
                    logInfo(values.description)

                    if let dataSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                        processAccountsStatus(dataSnapshot: dataSnapshot)
                        serviceStatusHandler(.updated)
                    }

                    if let status = values["status"] as? String {
                        if status == Constants.CredentialStatus.created {
                            serviceStatusHandler(.updated)
                        }

                        if status == Constants.CredentialStatus.success && !transactionsCreated {
                            transactionsCreated = true
                            serviceStatusHandler(.success)
                        }

                        if status == Constants.CredentialStatus.failure {
                            errorMessage = values["message"] as? String
                            serviceStatusHandler(.failure)
                        }

                        if status == Constants.CredentialStatus.interactive {
                            token = values["bankToken"] as? String
                            serviceStatusHandler(.interactive)
                        }
                    }
                }
            }) { error in
                logError(error as NSError)
                self.errorMessage = error.localizedDescription
                self.serviceStatusHandler(.failure)
            }
        }
    }

    private func processAccountsStatus(dataSnapshot: [DataSnapshot]) {
        for snap in dataSnapshot {
            if (snap.value as? Dictionary<String, AnyObject>) != nil {
                for value in snap.children {
                    let account = value as! DataSnapshot
                    let valueDictionary = account.value as! [String: AnyObject]
                    
                    let accountName = valueDictionary["name"] as? String ?? ""
                    let accountStatus = valueDictionary["status"] as? String ?? ""
                    
                    let transaction = AccountStatus(id: account.key,
                                                    name: accountName,
                                                    status: accountStatus)
                    
                    if accountStatus == Constants.CredentialStatus.accountCreated {
                        let credentialAccount = CredentialAccount(credentialId: self.credentialId,
                                                                  accountId: account.key,
                                                                  name: accountName,
                                                                  status: accountStatus)
                        
                        credentialAccounts.append(credentialAccount)
                    }
                    
                    let filtered = accounts.filter { accountFound in
                        accountFound.id == account.key
                    }
                    
                    if filtered.isEmpty {
                        accounts.append(transaction)
                    }
                    
                    filtered.first?.status = accountStatus
                }
            }
        }
    }
}
