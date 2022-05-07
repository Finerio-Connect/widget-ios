//
//  OnboardingMainVC.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 25/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

class OnboardingMainVC: BaseViewController {
    // Components
    var mainView: FCOnboardingMainView!
    
    // Vars
    private var onboardingModel: Onboarding!
    
    // Inits
    init(onboardingModel: Onboarding) {
        self.onboardingModel = onboardingModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = Configuration.shared.palette.backgroundView.dynamicColor
        setLayoutViews()
    }
}

// MARK: - Layout
extension OnboardingMainVC {
    func setLayoutViews() {
        mainView = FCOnboardingMainView(onboarding: self.onboardingModel)
        mainView.delegate = self
        self.view.addSubview(mainView)
        
        mainView.topAnchor(equalTo: self.view.safeTopAnchor)
        mainView.leadingAnchor(equalTo: self.view.leadingAnchor)
        mainView.trailingAnchor(equalTo: self.view.trailingAnchor)
        mainView.bottomAnchor(equalTo: self.view.safeBottomAnchor)
    }
}

// MARK: - OnboardingMainView Delegate
extension OnboardingMainVC: FCOnboardingMainViewDelegate {
    func selectedLinkedText() {
        let model = Configuration.shared.onboarding
        let coordinator = OnboardingCoordinator(context: context!, onboardingModel: model)
        coordinator.nextViewController()
    }
    
    func selectedContinueButton() {
        UserConfig.hasShownOnboarding = true
        
        let bankCoordinator = BankCoordinator(context: self.context!)
        context?.initialize(coordinator: bankCoordinator)
    }
}
