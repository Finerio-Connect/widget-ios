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

    init(context: Context, credentialId: String) {
        self.context = context
        self.credentialId = credentialId
    }

    func start() {
        let viewController = AccountViewController()
        viewController.viewModel = AccountViewModel()
        (viewController.viewModel as! AccountViewModel).credentialId = credentialId
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
}
