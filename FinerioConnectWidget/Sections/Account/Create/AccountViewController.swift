//
//  AccountViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit
import nanopb

internal class AccountViewController: BaseViewController {
    // Components
    var accountCreationView: FCAccountCreationView = FCAccountCreationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.backgroundColor = .white
        
        view.addSubview(accountCreationView)
        accountCreationView.delegate = self
        accountCreationView.topAnchor(equalTo: view.topAnchor)
        accountCreationView.leadingAnchor(equalTo: view.leadingAnchor)
        accountCreationView.trailingAnchor(equalTo: view.trailingAnchor)
        accountCreationView.bottomAnchor(equalTo: view.bottomAnchor)
    }
}

// MARK: - GestureRecognizerDelegate
extension AccountViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Disable back swipe
        return false
    }
}

// MARK: - Account Creation View Delegate
extension AccountViewController: FCAccountCreationViewDelegate {
    func accountCreationView(_ accountCreationView: FCAccountCreationView, onSuccess: ServiceStatus, bank: Bank) {
        self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!,
                                                                       serviceStatus: onSuccess,
                                                                       bank: bank))
    }
    
    func accountCreationView(_ accountCreationView: FCAccountCreationView, onFailure: ServiceStatus, message: String, bank: Bank) {
        self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!,
                                                                       serviceStatus: .failure,
                                                                       errorMessage: message,
                                                                       bank: bank))
    }
    
    func accountCreationView(_ accountCreationView: FCAccountCreationView, accountCreated: CredentialAccount) {
        print("AccountCreated_Delegate_Name: \(accountCreated.name)")
        print("AccountCreated_Delegate_CredentialId: \(accountCreated.credentialId)")
        print("AccountCreated_Delegate_Status: \(accountCreated.status)")
        print("AccountCreated_Delegate_AccountId: \(accountCreated.accountId)")
        print("\n")
    }
}
