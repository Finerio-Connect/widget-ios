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
    var bank: Bank!

    init(context: Context, serviceStatus: ServiceStatus, errorMessage: String? = nil, bank: Bank) {
        self.context = context
        self.serviceStatus = serviceStatus
        self.errorMessage = errorMessage
        self.bank = bank
    }

    func start() {
        let viewController = AccountStatusViewController()
        viewController.accountStatusView.setBank(bank)
        viewController.accountStatusView.setStatus(serviceStatus ?? .failure)
//        viewController.viewModel = AccountStatusViewModel()
//        (viewController.viewModel as! AccountStatusViewModel).serviceStatus = serviceStatus
//        (viewController.viewModel as! AccountStatusViewModel).errorMessage = errorMessage
//        (viewController.viewModel as! AccountStatusViewModel).bank = bank
        
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
}
