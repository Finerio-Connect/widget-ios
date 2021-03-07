//
//  UIViewController+Extension.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal extension UIViewController {
    var previousViewController: UIViewController? {
        if let controllersOnNavStack = navigationController?.viewControllers {
            let n = controllersOnNavStack.count
            // if self is still on Navigation stack
            if controllersOnNavStack.last === self, n > 1 {
                return controllersOnNavStack[n - 2]
            } else if n > 0 {
                return controllersOnNavStack[n - 1]
            }
        }
        return nil
    }

    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }

    private func topViewController() -> UIViewController? {
        var rootVC = UIApplication.shared
            .keyWindow?
            .rootViewController
        while let presentedController = rootVC?.presentedViewController {
            rootVC = presentedController
        }

        return rootVC
    }
}
