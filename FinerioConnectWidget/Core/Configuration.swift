//
//  Configuration.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

internal final class Configuration {
    static var shared = Configuration()

    // MARK: Global Constants

    static let ErrorDomain = "com.finerioconnect.network"
    static let FinerioConnectWidgetErrorKey = "FinerioConnectWidgetMessage"
    static let FinerioConnectWidgetErrorDebugKey = "FinerioConnectWidgetDebugMessage"

    // MARK: Global Variables

    var widgetId: String = ""
    var customerId: String?
    var customerName: String = ""
    var countryCode: String = Constants.Country.code
    var showCountryOptions: Bool = true
    var showBankTypeOptions: Bool = true
    var showOnboarding: Bool = true
    var onboarding: Onboarding = onboardingFinerioData
    var showChat: Bool = true
    var bankType: BankType = .personal
    var automaticFetching: Bool!
    var state: String!
    var logLevel: LogLevel = .info
    var environment: Environment = .sandbox
    var texts = Texts()
    var palette = Palette()
    var animations = Animations()
    var font: String? = nil ?? Constants.Fonts.defaultFontName
    let app: AppProtocol = App()
    var theme: Theme = .light
}
