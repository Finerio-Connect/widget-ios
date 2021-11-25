//
//  AccountCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

internal class AccountCoordinator: Coordinator {
    var context: Context?
    var credentialId: String?
    var bank: Bank!

    init(context: Context, credentialId: String, bank: Bank) {
        self.context = context
        self.credentialId = credentialId
        self.bank = bank
    }

    func start() {
        let viewController = AccountViewController()
        viewController.viewModel = AccountViewModel()
        (viewController.viewModel as! AccountViewModel).credentialId = credentialId
        (viewController.viewModel as! AccountViewModel).bank = bank
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
}
