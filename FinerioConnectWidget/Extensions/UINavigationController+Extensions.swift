//
//  UINavigationController+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

extension UINavigationController {
    func containsViewController(ofKind kind: AnyClass) -> Bool {
        return viewControllers.contains(where: { $0.isKind(of: kind) })
    }

    func popPushToViewController(ofKind kind: AnyClass, pushController: UIViewController) {
        if containsViewController(ofKind: kind) {
            for controller in viewControllers {
                if controller.isKind(of: kind) {
                    popToViewController(controller, animated: true)
                    break
                }
            }
        } else {
            pushViewController(pushController, animated: true)
        }
    }

    func backToViewController(_ viewController: Any) {
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
                popToViewController(element, animated: true)
                break
            }
        }
    }
}
