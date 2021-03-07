//
//  AccountViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import FirebaseDatabase

internal class AccountViewModel {
    var errorMessage: String!
    var token: String!
    var credentialId: String!
    var accounts: [AccountStatus] = []
    var currentAccountId: String = ""
    var accountCreated: Bool = false
    var transactionsCreated: Bool = false

    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }
    let databaseReference = Database.database().reference()

    func getTitle() -> String {
        return Constants.Titles.bankSection
    }

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
                    if let dataSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                        processAccountsStatus(dataSnapshot: dataSnapshot)
                    }

                    if let status = values["status"] {
                        if status as! String == Constants.CredentialStatus.success {
                            accountCreated = true
                            transactionsCreated = true

                            accounts.forEach { (account: AccountStatus) in
                                if account.status == Constants.CredentialStatus.accountCreated {
                                    transactionsCreated = false
                                }
                            }
                            serviceStatusHandler(.updated)
                        }

                        if status as! String == Constants.CredentialStatus.failure {
                            errorMessage = values["message"] as? String
                            serviceStatusHandler(.failure)
                        }

                        if status as! String == Constants.CredentialStatus.interactive {
                            token = values["bankToken"] as? String
                            serviceStatusHandler(.interactive)
                        }
                    }
                }
            }) { error in
                print(error.localizedDescription)
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

                    let transaction = AccountStatus(id: account.key, name: accountName, status: accountStatus)

                    let filtered = accounts.filter { accountFound in
                        accountFound.id == account.key
                    }

                    currentAccountId = account.key

                    if filtered.isEmpty {
                        accounts.append(transaction)
                    }

                    filtered.first?.status = accountStatus
                    serviceStatusHandler(.updated)
                }
            }
        }
    }
}
