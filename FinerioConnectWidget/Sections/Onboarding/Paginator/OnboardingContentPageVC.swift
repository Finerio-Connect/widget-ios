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
    init(onboardingPage: OnboardingModel.Page) {
        super.init()
        self.stepView = FCOnboardingStepView(onboardingPage: onboardingPage)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = FCComponentsStyle.backgroundView.dynamicColor

        self.setLayoutViews()
    }
}

extension OnboardingContentPageVC {
    func setLayoutViews() {
        view.addSubview(stepView)
        stepView.topAnchor(equalTo: view.safeTopAnchor)
        stepView.leadingAnchor(equalTo: view.leadingAnchor)
        stepView.trailingAnchor(equalTo: view.trailingAnchor)
        stepView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
}
