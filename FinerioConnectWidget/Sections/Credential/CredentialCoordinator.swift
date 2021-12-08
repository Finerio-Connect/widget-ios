//
//  CredentialCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class CredentialCoordinator: Coordinator {
    var context: Context?
    var bank: Bank?

    init(context: Context, bank: Bank) {
        self.context = context
        self.bank = bank
    }

    func start() {
        let viewController = CredentialViewController()
//        viewController.viewModel = CredentialViewModel()
        if let bank = self.bank {
            viewController.credentialsFormView.setBank(bank)
        }
//        (viewController.viewModel as! CredentialViewModel).bank = self.bank
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
}
