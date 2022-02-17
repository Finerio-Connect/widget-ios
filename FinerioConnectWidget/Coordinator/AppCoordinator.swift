//
//  AppCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal final class AppCoordinator: Coordinator {
    var context: Context?

    init(context: Context) {
        self.context = context
    }

    func start() {
        print("--->AppCoordinator: start()")
        let viewController = BankViewController()
//        viewController.viewModel = BankViewModel()
        viewController.coordinator = self
        viewController.context = context
        
        print("--->AppCoordinator: BankViewController traitCollection: \(viewController.traitCollection)")
        print("--->AppCoordinator: BankViewController View traitCollection: \(viewController.view.traitCollection)")
        
        context?.push(viewController: viewController)
    }
}
