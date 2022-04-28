//
//  OnboardingStepOneVC.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 28/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingStepOneVC: BaseViewController {
    // Components
    var stepView: FCOnboardingStepView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Configuration.shared.palette.viewControllersAIOBackground.dynamicColor
        
        stepView = FCOnboardingStepView()
        view.addSubview(stepView)
        
        stepView.topAnchor(equalTo: view.safeTopAnchor)
        stepView.leadingAnchor(equalTo: view.leadingAnchor)
        stepView.trailingAnchor(equalTo: view.trailingAnchor)
        stepView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
}
