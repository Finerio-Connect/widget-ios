//
//  BankCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class BankCoordinator: Coordinator {
    var context: Context?

    init(context: Context) {
        self.context = context
    }

    func start() {
        let viewController = BankViewController()
        viewController.coordinator = self
        viewController.context = context
        context?.navigationController.isNavigationBarHidden = false
        
//        viewController.navigationController?.isNavigationBarHidden = false
//        context?.navigationController.navigationBar.isHidden = false
//        viewController.navigationController?.navigationBar.isHidden = false
        context?.push(viewController: viewController)
    }
}
