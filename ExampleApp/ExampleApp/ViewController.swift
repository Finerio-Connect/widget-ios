//
//  ViewController.swift
//  ExampleApp
//
//  Created by René Sandoval on 04/03/21.
//

import FinerioAccountWidget
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Example FinerioConnectWidget"
        let finerioConnectWidget = FinerioConnectWidget.shared
        finerioConnectWidget.logLevel = .debug
        finerioConnectWidget.font = "Ubuntu"
        /// Country settings
//        finerioConnectWidget.countryCode = "CO"
        finerioConnectWidget.showCountryOptions = true
        /// Bank settings
        finerioConnectWidget.showBankTypeOptions = true
        finerioConnectWidget.bankType = .business
        
//        finerioConnectWidget.environment = .production
        finerioConnectWidget.texts = Texts(companyName: "Super Bank")

//        finerioConnectWidget.palette = Palette(
//            mainColor: UIColor(red: 0 / 255, green: 29 / 255, blue: 255 / 255, alpha: 1),
//            backgroundColor: UIColor(red: 170 / 255, green: 162 / 255, blue: 162 / 255, alpha: 1),
//            mainTextColor: UIColor(red: 218 / 255, green: 37 / 255, blue: 221 / 255, alpha: 1),
//            termsTextColor: UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1))
//
//        finerioConnectWidget.animations = Animations(
//            syncingAnimation: "syncingAnimation",
//            loadingAccountAnimation: "https://cdn.finerio.mx/widget/account_loading.json",
//            accountReadyAnimation: "accountReadyAnimation",
//            successAnimation: "successAnimation",
//            failureAnimation: "https://cdn.finerio.mx/widget/syncing_failure.json")

        finerioConnectWidget.start(
            widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
            customerName: "René Sandoval",
            presentingViewController: self)
    }
}
