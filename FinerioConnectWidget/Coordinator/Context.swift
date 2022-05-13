//
//  Context.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

internal final class Context {
    // Components
    var navigationController: UINavigationController
    // Vars
    weak var coordinator: Coordinator?

    // Inits
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Methods
    func initialize(coordinator: Coordinator) {
        self.coordinator = coordinator
        coordinator.start()
    }

    func push(viewController: BaseViewController) {
        let palette = Configuration.shared.palette
        self.navigationController.setStatusBar(backgroundColor: palette.statusBarBackground)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop(viewController: BaseViewController) {
        self.navigationController.viewControllers.removeAll(where: {$0 === viewController})
    }
    
    func popToRoot() {
        let firstVC = self.navigationController.viewControllers.removeFirst()
        self.navigationController.viewControllers.removeAll()
        self.navigationController.viewControllers.append(firstVC)
    }
}
