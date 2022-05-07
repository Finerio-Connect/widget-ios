//
//  AppCoordinator.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal final class AppCoordinator: Coordinator {
    var context: Context?
    
    init(context: Context) {
        self.context = context
    }
    
    func start() {
        let showOnboarding = Configuration.shared.showOnboarding
        let hasShownOnboarding = UserConfig.hasShownOnboarding
        
        if showOnboarding && (hasShownOnboarding == false) {
            let onboardingModel = Configuration.shared.onboarding
            let onboardingMainCoordinator = OnboardingCoordinator(context: self.context!,
                                                                  onboardingModel: onboardingModel)
            onboardingMainCoordinator.start()
        } else {
            let bankCoordinator = BankCoordinator(context: self.context!)
            bankCoordinator.start()
        }
    }
}
