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
        let accountStatusView = FCAccountStatusView()
        accountStatusView.delegate = self
        
        view.addSubview(accountStatusView)
        accountStatusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountStatusView.topAnchor.constraint(equalTo: view.topAnchor),
            accountStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountStatusView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Inyecta los datos necesarios para la vista.
        let bank = Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active")
        accountStatusView.setBank(bank)
        accountStatusView.setStatus(.success)
    }
    
    func configureFinerioConnectWidget() {
        let singleton = FinerioConnectWidget.shared
        //        singleton.start(widgetId: "NOT_VALID_KEY",
        singleton.start(widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
                        customerName: "René Sandoval")
    }
}

extension TestsViewController: FCAccountStatusViewDelegate {
    func accountStatusView(didSelectContinueButton: UIButton) {
        // Your implementation
    }
    
    func accountStatusView(didSelectExitButton: UIButton) {
        // Your implementation
    }
}



//extension TestsViewController: FCCredentialsFormViewDelegate {
//    func credentialsFormView(onActive: ServiceStatus, bank: Bank, nextFlowView: FCAccountStatusView) {
//        // Your implementation
//        print("ON ACTIVE: \(bank)")
//
//        let vc = UIViewController()
//        vc.view.backgroundColor = .white
//        vc.view.addSubview(nextFlowView)
//        nextFlowView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//                nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
//                nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
//                nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
//                nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
//            ])
//
//        self.present(vc, animated: true)
//    }
//
//    func credentialsFormView(onSuccess: ServiceStatus, bank: Bank, credentialId: String, nextFlowView: FCAccountCreationView) {
//        // Your implementation
//        print("ON SUCCESS, BANK: \(bank), CREDENTIALID: \(credentialId)")
//
//        let vc = UIViewController()
//        vc.view.backgroundColor = .white
//        vc.view.addSubview(nextFlowView)
//        nextFlowView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//                nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
//                nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
//                nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
//                nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
//            ])
//
//        self.present(vc, animated: true)
//    }
//
//    func credentialsFormView(onFailure: ServiceStatus, bank: Bank) {
//        // Your implementation
//        print("ON FAILURE: \(bank)")
//    }
//
//    func credentialsFormView(onError: ServiceStatus, message: String) {
//        // Your implementation
//        print("ON ERROR: \(message)")
//    }
//}
