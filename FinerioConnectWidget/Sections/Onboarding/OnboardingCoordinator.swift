//
//  OnboardingCoordinator.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 06/05/22.
//

import Foundation

internal class OnboardingCoordinator: Coordinator {
    var context: Context?
    var onboardingModel: Onboarding

    init(context: Context, onboardingModel: Onboarding) {
        self.context = context
        self.onboardingModel = onboardingModel
    }

    func start() {
        let viewController = OnboardingMainVC(onboardingModel: onboardingModel)
        viewController.coordinator = self
        viewController.context = context
        context?.push(viewController: viewController)
    }
    
    func nextViewController() {
        if let pages = onboardingModel.onboardingPages {
            let viewController = OnboardingPageVC(pages: pages)
            viewController.coordinator = self
            viewController.context = context
            context?.push(viewController: viewController)
        }
    }
}
