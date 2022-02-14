//
//  TestsViewController.swift
//  ExampleApp
//
//  Created by Jesus G on 24/01/22.
//

import UIKit
import FinerioAccountWidget

class TestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Inicializa el FCWidget
        configureFinerioConnectWidget()
        
        // Obtiene la vista requerida del FCWidget
        let bankSelectionView = FCBankSelectionView()
        bankSelectionView.delegate = self
        
        view.addSubview(bankSelectionView)
        bankSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bankSelectionView.topAnchor.constraint(equalTo: view.topAnchor),
            bankSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bankSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bankSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Inyecta los datos necesarios para la vista.
        //        let bank = Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active")
        //        let credentialId = "963e8a4e-bf28-4341-b7c3-a0f1fe52feca"
        //        ON SUCCESS, BANK: Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active"), CREDENTIALID: 963e8a4e-bf28-4341-b7c3-a0f1fe52feca
        //        accountStatusView.setBank(bank)
        //        accountStatusView.setStatus(.failure)
    }
    
    func configureFinerioConnectWidget() {
        let singleton = FinerioConnectWidget.shared
        
//        singleton.palette.banksBackground = FCColor(light: .orange, dark: .purple)
//        singleton.palette.banksListCellBackground = FCColor(light: .orange, dark: .purple)
        
        singleton.start(widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
                        customerName: "René Sandoval")
    }
}

extension TestsViewController: FCBankSelectionViewDelegate {
    func bankSelectionView(onFailure: ServiceStatus, message: String) {
        print(message)
    }
    
    func bankSelectionView(didSelect bank: Bank, nextFlowView: FCCredentialsFormView) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.view.addSubview(nextFlowView)
        nextFlowView.delegate = self
        nextFlowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])
        
        self.present(vc, animated: true)
    }
}



extension TestsViewController: FCCredentialsFormViewDelegate {
    func credentialsFormView(onActive: ServiceStatus, bank: Bank, nextFlowView: FCAccountStatusView) {
        // Your implementation
        print("ON ACTIVE: \(bank)")

        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.view.addSubview(nextFlowView)
        nextFlowView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
                nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
                nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            ])

        self.present(vc, animated: true)
    }

    func credentialsFormView(onSuccess: ServiceStatus, bank: Bank, credentialId: String, nextFlowView: FCAccountCreationView) {
        // Your implementation
        print("ON SUCCESS, BANK: \(bank), CREDENTIALID: \(credentialId)")

        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.view.addSubview(nextFlowView)
        nextFlowView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
                nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
                nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            ])

        self.present(vc, animated: true)
    }

    func credentialsFormView(onFailure: ServiceStatus, bank: Bank) {
        // Your implementation
        print("ON FAILURE: \(bank)")
    }

    func credentialsFormView(onError: ServiceStatus, message: String) {
        // Your implementation
        print("ON ERROR: \(message)")
    }
}
