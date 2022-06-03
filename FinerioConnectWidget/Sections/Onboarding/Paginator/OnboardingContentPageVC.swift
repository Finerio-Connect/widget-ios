//
//  OnboardingContentPageVC.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 28/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingContentPageVC: BaseViewController {
    // Components
    var stepView: FCOnboardingStepView!
    
    // Vars
    var pageIndex: Int!
    
    // Inits
    init(onboardingPage: Onboarding.OnboardingPage) {
        super.init()
        self.stepView = FCOnboardingStepView(onboardingPage: onboardingPage)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Configuration.shared.palette.backgroundView.dynamicColor
        setLayoutViews()
    }
}

// MARK: - Layout
extension OnboardingContentPageVC {
    func setLayoutViews() {
        view.addSubview(stepView)
        stepView.topAnchor(equalTo: view.safeTopAnchor)
        stepView.leadingAnchor(equalTo: view.leadingAnchor)
        stepView.trailingAnchor(equalTo: view.trailingAnchor)
        stepView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
}
