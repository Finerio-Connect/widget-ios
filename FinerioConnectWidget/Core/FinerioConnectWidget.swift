//
//  FinerioConnectWidget.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import FirebaseCore
import UIKit

/// Type of Applivery's logs you want displayed in the debug console
public enum LogLevel: Int {
    case none = 0
    case error = 1
    case info = 2
    case debug = 3
}

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

    // MARK: - Private properties

    private let configuration: Configuration

    // MARK: Initializers

    override convenience init() {
        self.init(configuration: Configuration.shared)
    }

    internal init(configuration: Configuration) {
        self.configuration = configuration
        logLevel = .info
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
