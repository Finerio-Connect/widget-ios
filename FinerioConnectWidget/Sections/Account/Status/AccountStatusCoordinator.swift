//
//  AccountStatusCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Foundation

internal class AccountStatusCoordinator: Coordinator {
    var context: Context?
    var serviceStatus: ServiceStatus?
    var errorMessage: String?

    init(context: Context, serviceStatus: ServiceStatus, errorMessage: String? = nil) {
        self.context = context
        self.serviceStatus = serviceStatus
        self.errorMessage = errorMessage
    }

    func start() {
        let viewController = AccountStatusViewController()
        viewController.viewModel = AccountStatusViewModel()
        (viewController.viewModel as! AccountStatusViewModel).serviceStatus = serviceStatus
        (viewController.viewModel as! AccountStatusViewModel).errorMessage = errorMessage
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
}
