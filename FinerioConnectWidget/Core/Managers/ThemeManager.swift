//
//  ThemeManager.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import UIKit

final internal class ThemeManager {
    static let shared = ThemeManager()
    var navigationControllerFinerio: NavigationControllerFinerio?
}

extension ThemeManager {
    func saveNavBarStyleFor(navigationController: UINavigationController) {
        navigationControllerFinerio = NavigationControllerFinerio(navigationController: navigationController)
    }

    func applyAppNavBarStyle(navigationController: UINavigationController) {
        guard let navControllerFinerio = navigationControllerFinerio else {
            return
        }
        navigationController.navigationBar.barTintColor = navControllerFinerio.navBarTintColor
        navigationController.navigationBar.titleTextAttributes = navControllerFinerio.navTitleTextAttributes
        navigationController.navigationBar.tintColor = navControllerFinerio.navTintColor
        navigationController.navigationBar.titleTextAttributes = navControllerFinerio.navTitleTextAttributes
        navigationController.navigationBar.isTranslucent = navControllerFinerio.navIsTranslucent
        navigationController.navigationBar.backgroundColor = navControllerFinerio.navBackgroundColor
        navigationController.navigationBar.setBackgroundImage(navControllerFinerio.navBackgroundImage, for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = navControllerFinerio.navShadowImage
        navigationController.delegate = navControllerFinerio.customDelegate
        if navControllerFinerio.navBarStyle != nil {
            navigationController.navigationBar.barStyle = navControllerFinerio.navBarStyle!
        }
        navigationController.interactivePopGestureRecognizer?.isEnabled = navControllerFinerio.swipeBackGesture
        navigationController.setNavigationBarHidden(navControllerFinerio.isNavigationBarHidden, animated: false)
    }
}
