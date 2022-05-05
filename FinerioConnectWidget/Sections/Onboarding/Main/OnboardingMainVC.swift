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
extension OnboardingMainVC {
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
extension OnboardingMainVC: FCOnboardingMainViewDelegate {
    func selectedLinkedText() {
        #warning("LLAMAR A COORDINATOR")
        if let pages = onboardingModel.pages {
            let onboardingPageVC = OnboardingPageVC(pages: pages)
            self.navigationController?.pushViewController(onboardingPageVC, animated: true)
        }
    }
    
    func selectedContinueButton() {
#warning("LLAMAR A COORDINATOR")
        print("CONTINUAR FLUJO NORMAL DEL WIDGET Y SALIR DEL ONBOARDING")
    }
}
