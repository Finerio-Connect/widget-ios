//
//  OnboardingVC.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 25/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingViewController: BaseViewController {
    // Components
    var mainView: FCOnboardingMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Configuration.shared.palette.viewControllersAIOBackground.dynamicColor
        
        mainView = FCOnboardingMainView()
        mainView.delegate = self
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)
        
        mainView.topAnchor(equalTo: self.view.safeTopAnchor)
        mainView.leadingAnchor(equalTo: self.view.leadingAnchor)
        mainView.trailingAnchor(equalTo: self.view.trailingAnchor)
        mainView.bottomAnchor(equalTo: self.view.safeBottomAnchor)
    }
}

extension OnboardingViewController: FCOnboardingMainViewDelegate {
    func selectedContinueButton() {
        let stepOneVC = OnboardingStepOneVC()
        self.navigationController?.pushViewController(stepOneVC, animated: true)
    }
    
    func selectedExitButton() {
        self.dismiss(animated: true)
    }
}
