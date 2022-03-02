//
//  FAANavigationController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

internal class OriginalNavigationController {
    var navBarTintColor: UIColor?
    var navTintColor: UIColor?
    var navTitleTextAttributes: [NSAttributedString.Key: Any]?
    var navIsTranslucent: Bool = false
    var navViewBackgroundColor: UIColor?
    var navBackgroundColor: UIColor?
    var navBackgroundImage: UIImage?
    var navShadowImage: UIImage?
    var navBarStyle: UIBarStyle?
    weak var customDelegate: UINavigationControllerDelegate?
    var swipeBackGesture: Bool = true
    var isNavigationBarHidden: Bool = true

    init(navigationController: UINavigationController) {
        navBarTintColor = navigationController.navigationBar.barTintColor
        navTintColor = navigationController.navigationBar.tintColor
        navTitleTextAttributes = navigationController.navigationBar.titleTextAttributes
        navIsTranslucent = navigationController.navigationBar.isTranslucent
        navViewBackgroundColor = navigationController.view.backgroundColor
        navBackgroundColor = navigationController.navigationBar.backgroundColor
        navBackgroundImage = navigationController.navigationBar.backgroundImage(for: .default)
        navShadowImage = navigationController.navigationBar.shadowImage
        navBarStyle = navigationController.navigationBar.barStyle
        customDelegate = navigationController.delegate
        isNavigationBarHidden = navigationController.isNavigationBarHidden
        if let backGesture = navigationController.interactivePopGestureRecognizer?.isEnabled {
            swipeBackGesture = backGesture
        }
    }
}

class FAANavigationController: UINavigationController {
    override func viewDidLoad() {
//        navigationBar.barTintColor = Colors.mainColor
//        navigationBar.titleTextAttributes = [
//            .foregroundColor: Colors.mainColor,
//            .font: UIFont.systemFont(
//                ofSize: 22,
//                weight: .light
//            ),
//        ]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
