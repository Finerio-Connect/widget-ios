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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.backgroundColor = .white
        
        view.addSubview(accountStatusView)
        accountStatusView.topAnchor(equalTo: view.safeTopAnchor)
        accountStatusView.leadingAnchor(equalTo: view.leadingAnchor)
        accountStatusView.trailingAnchor(equalTo: view.trailingAnchor)
        accountStatusView.bottomAnchor(equalTo: view.safeBottomAnchor)
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
