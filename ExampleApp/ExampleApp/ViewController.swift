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
    var currentVersionTest: Double = 1.0
    var oldVersionTest: Double = 1.0
    
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
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let buttonTest = UIButton()
        buttonTest.backgroundColor = UIColor(red: 63 / 255, green: 216 / 255, blue: 175 / 255, alpha: 1)
        buttonTest.setTitle("TEST VC", for: .normal)
        buttonTest.addTarget(self, action: #selector(testViewController), for: .touchUpInside)
        stackView.addArrangedSubview(buttonTest)
        
        let buttonApp = UIButton()
        buttonApp.backgroundColor = .purple
        buttonApp.setTitle("VERSION APP UPDATE", for: .normal)
        buttonApp.addTarget(self, action: #selector(changeVersionOnRuntime), for: .touchUpInside)
        stackView.addArrangedSubview(buttonApp)
    }
}

//MARK: - Start Widget
extension ViewController {
    @objc private func startWidget() {
        let finerioConnectWidget = FinerioConnectWidget.shared
        /// ENVIRONMENT SETTINGS
        //        finerioConnectWidget.environment = .production
        
        /// ZENDESK SETTINGS
        //        finerioConnectWidget.showChat = true // Zendesk help chat
        
        /// ONBOARDING SETTINGS
        finerioConnectWidget.showOnboarding = true // Show onboarding tutorial in the beginning
        //        finerioConnectWidget.onboarding = prepareOnboardingData() //Set your own onboarding data
        //        finerioConnectWidget.hasShownOnboarding = false // To handle the reset of onboarding flow
        demoValidateVersionUpdate(finerioConnectWidget)
        
        /// COUNTRY SETTINGS
        //        finerioConnectWidget.countryCode = "MX"
        //        finerioConnectWidget.showCountryOptions = false
        
        /// BANK SETTINGS
        //        finerioConnectWidget.showBankTypeOptions = true
        //        finerioConnectWidget.bankType = .personal
        
        /// THEME APPEARANCE SETTINGS
        finerioConnectWidget.theme = .automatic
        
        /// TEXTS SETTINGS
        finerioConnectWidget.texts = Texts(companyName: "Super Bank Company")
        //        finerioConnectWidget.font = "Ubuntu"
        
        /// ANIMATIONS SETTINGS
        //        finerioConnectWidget.animations = Animations(
        //            loadingAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
        //            accountCreationAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json")
        
        /// PALETTE SETTTINGS
        //        let fcColor = FCColor(light: .yellow, dark: .purple)
        //        finerioConnectWidget.palette.backgroundView = fcColor
        //        finerioConnectWidget.palette.buttonActiveBackground = fcColor
        
        
        finerioConnectWidget.start(
            widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
            customerName: "René Sandoval",
            presentingViewController: self)
    }
}


// MARK: - Events
extension ViewController {
    @objc func testViewController() {
        let vc = TestsViewController()
        present(vc, animated: true)
    }
    
    @objc private func changeVersionOnRuntime() {
        print("OldVersionApp: \(oldVersionTest)")
        oldVersionTest = currentVersionTest
        print("OldVersionApp: \(oldVersionTest)")
        
        print("CurrentVersionApp: \(currentVersionTest)")
        currentVersionTest += 1
        print("CurrentVersionApp: \(currentVersionTest)")
    }
}

// MARK: - Auxiliar Methods
extension ViewController {
    func prepareOnboardingData() -> Onboarding {
        let pageOne = Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.up.filled")!,
                                                icon: UIImage(systemName: "dpad.up.filled")!,
                                                title: "ITEM UNO",
                                                detail: TextWithLink(fullPlainText: "DESCRIPCION PAGE UNO"))
        
        let pageTwo = Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.right.filled")!,
                                                icon: UIImage(systemName: "dpad.right.filled")!,
                                                title: "ITEM DOS",
                                                detail: TextWithLink(fullPlainText: "DESCRIPCION PAGE DOS"))
        
        let pageThree = Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.down.filled")!,
                                                  icon: UIImage(systemName: "dpad.down.filled")!,
                                                  title: "ITEM TRES",
                                                  detail: TextWithLink(fullPlainText: "DESCRIPCION PAGE TRES"))
        
        let pageFour = Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.left.filled")!,
                                                 icon: UIImage(systemName: "dpad.left.filled")!,
                                                 title: "ITEM CUATRO",
                                                 detail: TextWithLink(fullPlainText: "DESCRIPCION PAGE CUATRO"))
        
        let pages = [pageOne, pageTwo, pageThree, pageFour]
        
        let main = Onboarding.Main(icon: UIImage(systemName: "gamecontroller")!,
                                   title: "ONBOARDING WIDGET VERSION \(currentVersionTest)",
                                   description: "Descubre las novedades de esta actualización",
                                   actionText: TextWithLink(fullPlainText: "Ver nuevas funcionalidades"))
        let onboardingDataClient = Onboarding(main: main, pages: pages)
        return onboardingDataClient
    }
    
    // Demo validation to reset onboarding on Update Version
    private func demoValidateVersionUpdate(_ finerioConnectWidget: FinerioConnectWidget) {
        if currentVersionTest > oldVersionTest {
            oldVersionTest = currentVersionTest
            // this will reset the onboarding
            finerioConnectWidget.hasShownOnboarding = false
            finerioConnectWidget.onboarding = prepareOnboardingData()
        }
    }
}
