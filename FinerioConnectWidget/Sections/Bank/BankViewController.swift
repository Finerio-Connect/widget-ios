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
}

//MARK: - FCBankSelectionView Delegate
extension BankViewController: FCBankSelectionViewDelegate {
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, onFailure: ServiceStatus, message: String) {
        self.showAlert(message, viewController: self)
    }
    
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect bank: Bank) {
        let coordinator = CredentialCoordinator(context: context!, bank: bank)
        context?.initialize(coordinator: coordinator)
    }
}
