//
//  App.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 12/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

internal protocol AppProtocol {
    func bundleId() -> String
    func getSDKVersion() -> String
    func getVersion() -> String
    func getVersionName() -> String
    func showAlert(_ message: String, viewController: UIViewController)
    func showErrorAlert(_ message: String, viewController: UIViewController, errorHandler: @escaping () -> Void)
    func waitForReadyThen(_ onReady: @escaping () -> Void)
}

final internal class App: AppProtocol {
    private lazy var alertError: UIAlertController = UIAlertController()
    private lazy var alertLogin: UIAlertController = UIAlertController()

    func bundleId() -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            logWarn("No bundle identifier found")
            return "no_id"
        }

        return bundleId
    }

    func getVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "NO_VERSION_FOUND"
        }
        return version
    }

    func getVersionName() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "NO_VERSION_FOUND"
        }
        return version
    }

    func getSDKVersion() -> String {
        guard let version = Bundle.finerioConnectWidget().infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "NO_VERSION_FOUND"
        }
        return version
    }

    func showAlert(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: literal(.companyName), message: message, preferredStyle: .alert)

        let actionLater = UIAlertAction(title: fLocaleAlertButtonOk, style: .cancel, handler: nil)
        alert.addAction(actionLater)

        viewController.present(alert, animated: true, completion: nil)
    }

    func showErrorAlert(_ message: String, viewController: UIViewController, errorHandler: @escaping () -> Void) {
        alertError = UIAlertController(title: literal(.companyName), message: message, preferredStyle: .alert)

        let actionCancel = UIAlertAction(title: fLocaleAlertButtonCancel, style: .cancel, handler: nil)
        let actionError = UIAlertAction(title: fLocaleAlertButtonError, style: .default) { _ in
            errorHandler()
        }

        alertError.addAction(actionCancel)
        alertError.addAction(actionError)

        viewController.present(alertError, animated: true, completion: nil)
    }

    func presentModal(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .overFullScreen
        let topVC = topViewController()
        topVC?.present(viewController, animated: animated, completion: nil)
    }

    func waitForReadyThen(_ onReady: @escaping () -> Void) {
        runInBackground {
            self.sleepUntilReady()
            runOnMainThreadAsync(onReady)
        }
    }

    // MARK: - Private Helpers

    private func sleepUntilReady() {
        while !rootViewIsReady() {
            sleep(for: 0.1)
        }
    }

    private func rootViewIsReady() -> Bool {
        var isReady = false
        runOnMainThreadSynced {
            isReady = UIApplication.shared
                .keyWindow?
                .rootViewController?
                .isViewLoaded ?? false
        }
        return isReady
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
