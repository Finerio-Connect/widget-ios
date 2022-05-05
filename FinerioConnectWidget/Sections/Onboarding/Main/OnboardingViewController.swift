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
    
    // Vars
    private var onboardingModel: OnboardingModel!
    
    // Inits
    init(onboardingModel: OnboardingModel) {
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
extension OnboardingViewController {
    func setLayoutViews() {
        mainView = FCOnboardingMainView(main: onboardingModel.main)
        mainView.delegate = self
        self.view.addSubview(mainView)
        
        mainView.topAnchor(equalTo: self.view.safeTopAnchor)
        mainView.leadingAnchor(equalTo: self.view.leadingAnchor)
        mainView.trailingAnchor(equalTo: self.view.trailingAnchor)
        mainView.bottomAnchor(equalTo: self.view.safeBottomAnchor)
    }
}

// MARK: - OnboardingMainView Delegate
extension OnboardingViewController: FCOnboardingMainViewDelegate {
    func selectedContinueButton() {
        if let pages = onboardingModel.pages {
            let onboardingPageVC = OnboardingPageVC(onboardingModel: pages)
            self.navigationController?.pushViewController(onboardingPageVC, animated: true)
        }
    }
}
