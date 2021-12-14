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

    #warning("LOADING VIEW TEST UNFINISHED")
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // View Controller config
//        view.backgroundColor = .white
//
//        let loaderView = FCLoaderAnimationView()
//        /// Custom lottie values
////        loaderView.animationSource = "https://assets5.lottiefiles.com/packages/lf20_lmk0pfms.json"
////        loaderView.animationSource = "TestLottieLocal"
////        loaderView.animationSize = 100
////        loaderView.backgroundColor = .red.withAlphaComponent(0.5)
//
//        view.addSubview(loaderView)
//        loaderView.translatesAutoresizingMaskIntoConstraints = false
//        loaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//        // Buttons view controller
//        let buttonStart = UIButton(type: .system)
//        buttonStart.setTitle("START", for: .normal)
//        buttonStart.backgroundColor = .systemTeal
//        buttonStart.addTarget(loaderView, action: #selector(loaderView.start), for: .touchUpInside)
//
//        let buttonStop = UIButton(type: .system)
//        buttonStop.setTitle("STOP", for: .normal)
//        buttonStop.backgroundColor = .systemTeal
//        buttonStop.addTarget(loaderView, action: #selector(loaderView.stop), for: .touchUpInside)
//
//        let stackButtons = UIStackView(arrangedSubviews: [buttonStart, buttonStop])
//        stackButtons.axis = .vertical
//        stackButtons.spacing = 10
//        stackButtons.distribution = .fillEqually
//
//        view.addSubview(stackButtons)
//        stackButtons.translatesAutoresizingMaskIntoConstraints = false
//        stackButtons.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        stackButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example FinerioConnectWidget"

        FontBlaster.debugEnabled = true
        FontBlaster.blast { fonts -> Void in
            print("Loaded Fonts: \(fonts)")
        }

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 63 / 255, green: 216 / 255, blue: 175 / 255, alpha: 1)
        button.setTitle("Open SDK Account Aggregation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 18) ?? .boldSystemFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(startWidget), for: .touchUpInside)

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func startWidget() {
        let finerioConnectWidget = FinerioConnectWidget.shared
        finerioConnectWidget.logLevel = .debug
        finerioConnectWidget.font = "Ubuntu"
        /// Country settings
//        finerioConnectWidget.countryCode = "CO"
//        finerioConnectWidget.showCountryOptions = false
        /// Bank settings
//        finerioConnectWidget.showBankTypeOptions = false
//        finerioConnectWidget.bankType = .fiscal

//        finerioConnectWidget.environment = .production
        finerioConnectWidget.texts = Texts(companyName: "Super Bank")

//        finerioConnectWidget.palette = Palette(
//            mainColor: UIColor(red: 0 / 255, green: 29 / 255, blue: 255 / 255, alpha: 1),
//            backgroundColor: UIColor(red: 170 / 255, green: 162 / 255, blue: 162 / 255, alpha: 1),
//            mainTextColor: UIColor(red: 218 / 255, green: 37 / 255, blue: 221 / 255, alpha: 1),
//            termsTextColor: UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1))
//
//        finerioConnectWidget.animations = Animations(
//            loadingAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
//            accountCreationAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
//            successAnimation: "successAnimation",
//            failureAnimation: "https://cdn.finerio.mx/widget/syncing_failure.json")

        finerioConnectWidget.start(
            widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
            customerName: "René Sandoval",
            presentingViewController: self)
    }
}
