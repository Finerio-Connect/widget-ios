//
//  AccountStatusViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit

internal class AccountStatusViewController: BaseViewController {
    // Components
    var accountStatusView: FCAccountStatusView = FCAccountStatusView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = Configuration.shared.palette.backgroundView.dynamicColor

        accountStatusView.delegate = self

        view.addSubview(accountStatusView)
        accountStatusView.topAnchor(equalTo: view.safeTopAnchor)
        accountStatusView.leadingAnchor(equalTo: view.leadingAnchor)
        accountStatusView.trailingAnchor(equalTo: view.trailingAnchor)
        accountStatusView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Gesture Recognizer Delegate

extension AccountStatusViewController
    : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Disable back swipe
        return false
    }
}

// MARK: - AccountStatusView Delegate

extension AccountStatusViewController: FCAccountStatusViewDelegate {
    func accountStatusView(didSelectContinueButton: UIButton) {
        let topVC = UIApplication.fcTopViewController()
        topVC?.navigationController?.navigationBar.isHidden = false
        topVC?.navigationController?.backToViewController(BankViewController.self)
    }

    func accountStatusView(didSelectExitButton: UIButton) {
        let topVC = UIApplication.fcTopViewController()
        topVC?.navigationController?.navigationBar.isHidden = false
        topVC?.navigationController?.popToRootViewController(animated: true)
    }
}
