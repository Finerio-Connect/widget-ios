//
//  BankViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class BankViewController: BaseViewController {
    // Components
    private var bankSelectionView: FCBankSelectionView! // = FCBankSelectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .white
        
        bankSelectionView = FCBankSelectionView()
        view.addSubview(bankSelectionView)
        bankSelectionView.delegate = self
        bankSelectionView.topAnchor(equalTo: view.safeTopAnchor)
        bankSelectionView.leadingAnchor(equalTo: view.leadingAnchor)
        bankSelectionView.trailingAnchor(equalTo: view.trailingAnchor)
        bankSelectionView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("--->VC: TRAIT COLLECTION DID CHANGE")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("--->VC: UPDATE VIEW CONSTRAINTS")
    }
    
    override func viewWillLayoutSubviews() {
        print("--->VC: VIEW WILL LAYOUT SUBVIEWS")
        if #available(iOS 13.0, *) {
            #warning("TESTING")
//            self.navigationController?.overrideUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle // Aqui no funciona
//            self.overrideUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle // Funciona a medias
//            self.view.overrideUserInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle //FUNCIONA A MEDIAS
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidLayoutSubviews() {
        print("--->VC: VIEW DID LAYOUT SUBVIEWS")
    }
    
    
    
}

//MARK: - FCBankSelectionView Delegate
extension BankViewController: FCBankSelectionViewDelegate {
    func bankSelectionView(didSelect bank: Bank, nextFlowView: FCCredentialsFormView) {
        let coordinator = CredentialCoordinator(context: context!, bank: bank)
        context?.initialize(coordinator: coordinator)
    }
    
    func bankSelectionView(onFailure: ServiceStatus, message: String) {
        self.showAlert(message, viewController: self)
    }
}
