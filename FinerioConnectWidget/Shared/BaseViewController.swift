//
//  BaseViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import Mixpanel
import UIKit

internal class BaseViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var context: Context?
    var viewModel: Any!
    let app = Configuration.shared.app
    let reachability = Reachability()
    var animateDistance = CGFloat(0.0)
    let currentLoadingView = LoadingViewController()

    override open func viewDidLoad() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        view.backgroundColor = .clear

        if reachability?.connection == Reachability.Connection.none {
            let error = NSError.faaError(Constants.Texts.Errors.reachabilityError)
            app.showAlert(Constants.Texts.Errors.reachabilityError, viewController: self)
            logError(error)
            return
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func trackEvent(eventName: String, _ properties: Properties? = nil) {
        Mixpanel.mainInstance().track(event: eventName, properties: properties)
    }

    func startLoader() {
        currentLoadingView.modalTransitionStyle = .crossDissolve
        currentLoadingView.modalPresentationStyle = .fullScreen
        navigationController?.present(currentLoadingView, animated: false)
    }

    func stopLoader() {
        currentLoadingView.dismiss(animated: true)
    }

    func getConstraintConstant(firstValue: Double, secondValue: Double, value: Double = 0.0) -> CGFloat {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE || UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            return CGFloat(firstValue - value)
        }

        return CGFloat(secondValue)
    }
}
