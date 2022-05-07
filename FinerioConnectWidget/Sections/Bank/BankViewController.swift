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
    private var bankSelectionView: FCBankSelectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = FCComponentsStyle.backgroundView.dynamicColor
        
        bankSelectionView = FCBankSelectionView()
        view.addSubview(bankSelectionView)
        bankSelectionView.delegate = self
        bankSelectionView.topAnchor(equalTo: view.safeTopAnchor)
        bankSelectionView.leadingAnchor(equalTo: view.leadingAnchor)
        bankSelectionView.trailingAnchor(equalTo: view.trailingAnchor)
        bankSelectionView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // To enable the navBar
            navigationController?.navigationBar.isHidden = false
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
