//
//  CredentialViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class CredentialViewController: BaseViewController {
    // Components
    var credentialsFormView: FCCredentialsFormView = FCCredentialsFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = FCComponentsStyle.viewControllersAIOBackground.dynamicColor
        
        view.addSubview(credentialsFormView)
        credentialsFormView.delegate = self
        credentialsFormView.topAnchor(equalTo: view.safeTopAnchor)
        credentialsFormView.leadingAnchor(equalTo: view.leadingAnchor)
        credentialsFormView.trailingAnchor(equalTo: view.trailingAnchor)
        credentialsFormView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
}

// MARK: - Credentials Form View Delegate
extension CredentialViewController: FCCredentialsFormViewDelegate {
    func credentialsFormView(onActive: ServiceStatus, bank: Bank, nextFlowView: FCAccountStatusView) {
        self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!,
                                                                       serviceStatus: onActive,
                                                                       bank: bank))
    }
    
    func credentialsFormView(onSuccess: ServiceStatus, bank: Bank, credentialId: String, nextFlowView: FCAccountCreationView) {
        self.context?.initialize(coordinator: AccountCoordinator(context: self.context!,
                                                                 credentialId: credentialId,
                                                                 bank: bank))
    }
    
    func credentialsFormView(onFailure: ServiceStatus, bank: Bank) {
        self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!,
                                                                       serviceStatus: onFailure,
                                                                       bank: bank))
    }
    
    func credentialsFormView(onError: ServiceStatus, message: String) {
        self.showAlert(message, viewController: self)
    }
}
