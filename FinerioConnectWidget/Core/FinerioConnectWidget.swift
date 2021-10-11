//
//  FinerioConnectWidget.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import FirebaseCore
import UIKit

public final class FinerioConnectWidget: NSObject {
    // MARK: - Type Properties

    /// Singleton instance
    public static let shared = FinerioConnectWidget()

    public var presentingViewController: UIViewController?

    // MARK: - Instance Properties

    internal var context: Context?

    public var logLevel: LogLevel {
        didSet {
            configuration.logLevel = logLevel
        }
    }

    public var environment: Environment {
        didSet {
            configuration.environment = environment
        }
    }

    public var texts: Texts {
        didSet {
            configuration.texts = texts
        }
    }

    public var palette: Palette {
        didSet {
            configuration.palette = palette
        }
    }

    public var animations: Animations {
        didSet {
            configuration.animations = animations
        }
    }

    public var font: String = "" {
        didSet {
            configuration.font = font
        }
    }

    public var countryCode: String = "" {
        didSet {
            configuration.countryCode = countryCode
        }
    }
    
    public var showCountryOptions: Bool = true {
        didSet {
            configuration.showCountryOptions = showCountryOptions
        }
    }


    // MARK: - Private properties

    private let configuration: Configuration

    // MARK: Initializers

    override convenience init() {
        self.init(configuration: Configuration.shared)
    }

    internal init(configuration: Configuration) {
        self.configuration = configuration
        logLevel = .info
        environment = .sandbox
        texts = Texts()
        palette = Palette()
        animations = Animations()
        self.configuration.palette = palette
        self.configuration.texts = texts
        self.configuration.animations = animations
    }

    private func firebaseConfigure() {
        let filePath = Bundle.finerioConnectWidget().path(forResource: "GoogleService-Info", ofType: "plist")
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath!) else {
            assert(false, "Couldn't load config file")
            return
        }

        FirebaseApp.configure(options: fileopts)
        logInfo("Firebase Configuration")
    }

    public func start(widgetId: String, customerName: String, customerId: String? = nil, automaticFetching: Bool = true, state: String = "stateEncrypted", presentingViewController: UIViewController) {
        logInfo("FinerioConnectWidget is starting...")
        logInfo("SDK Version: \(Configuration.shared.app.getSDKVersion())")
        configuration.widgetId = widgetId
        configuration.customerName = customerName
        configuration.customerId = customerId
        configuration.automaticFetching = automaticFetching
        configuration.state = state

        self.presentingViewController = presentingViewController

        guard let navigationController = presentingViewController.navigationController else {
            logWarn("Couldn't initialize view controller")
            return
        }

        FontBlaster.debugEnabled = logLevel == .debug ? true : false
        FontBlaster.blast { fonts -> Void in
            logInfo("Loaded Fonts: \(fonts)")
        }

        firebaseConfigure()

        context = Context(with: navigationController)
        context?.initialize(coordinator: AppCoordinator(context: context!))
    }
}
