//
//  ViewController.swift
//  ExampleApp
//
//  Created by René Sandoval on 04/03/21.
//

import FinerioAccountWidget
import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example FinerioConnectWidget"

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red //UIColor(red: 63 / 255, green: 216 / 255, blue: 175 / 255, alpha: 1)
        button.setTitle("Open SDK Account Aggregation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 18) ?? .boldSystemFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(startWidget), for: .touchUpInside)

        stackView.addArrangedSubview(button)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let buttonTest = UIButton()
        buttonTest.backgroundColor = UIColor(red: 63 / 255, green: 216 / 255, blue: 175 / 255, alpha: 1)
        buttonTest.setTitle("TEST VC", for: .normal)
        buttonTest.addTarget(self, action: #selector(testViewController), for: .touchUpInside)
        stackView.addArrangedSubview(buttonTest)
    }
    
    @objc func testViewController() {
        let vc = TestsViewController()
        present(vc, animated: true)
    }

    @objc private func startWidget() {
        let finerioConnectWidget = FinerioConnectWidget.shared
//        finerioConnectWidget.font = "Ubuntu"
        /// Country settings
//        finerioConnectWidget.countryCode = "MX"
//        finerioConnectWidget.showCountryOptions = false
        /// Bank settings
//        finerioConnectWidget.showBankTypeOptions = true
//        finerioConnectWidget.bankType = .personal
        /// Theme appearance
        finerioConnectWidget.theme = .automatic
        
        

//        finerioConnectWidget.environment = .production
        finerioConnectWidget.texts = Texts(companyName: "Super Bank Company")

//        finerioConnectWidget.animations = Animations(
//            loadingAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
//            accountCreationAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
//            successAnimation: "successAnimation",
//            failureAnimation: "https://cdn.finerio.mx/widget/syncing_failure.json")
        
//        let fcColor = FCColor(light: .yellow, dark: .purple)
//        finerioConnectWidget.palette.banksBackground = fcColor
//        finerioConnectWidget.palette.credentialsBackground = fcColor
//        finerioConnectWidget.palette.accountCreationBackground = fcColor
//        finerioConnectWidget.palette.accountStatusBackground = fcColor
//        finerioConnectWidget.palette.statusBarBackground = fcColor
//        finerioConnectWidget.palette.viewControllersAIOBackground = fcColor

        
        
        finerioConnectWidget.start(
            widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
            customerName: "René Sandoval",
            presentingViewController: self)
    }
}



