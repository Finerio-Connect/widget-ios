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
    var automaticFetching: Bool!
    var state: String!
    var logLevel: LogLevel = .info
    var texts = Texts()
    var palette = Palette()
    var animations = Animations()
    let app: AppProtocol = App()
}
