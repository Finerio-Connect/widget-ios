//
//  UIApplication+Extensions.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 10/12/21.
//

import Foundation

public extension UIApplication {
    class func fcTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return fcTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return fcTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return fcTopViewController(controller: presented)
        }
        return controller
    }
}
