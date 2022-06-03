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
        let backgroundColor = Configuration.shared.palette.backgroundView.dynamicColor
        self.view.backgroundColor = backgroundColor
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
        
//        if let coordinator = coordinator as? OnboardingCoordinator {
//            coordinator.banksCoordinator()
//        }
        
        let bankCoordinator = BankCoordinator(context: self.context!)
        context?.pop(viewController: self)
        context?.initialize(coordinator: bankCoordinator)
    }
}
