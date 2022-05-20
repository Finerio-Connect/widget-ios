//
//  FCBaseView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 05/12/21.
//

import Mixpanel
import UIKit
import ZendeskSDK

public class FCBaseView: UIView {
    // Vars
    let app = Configuration.shared.app
    let reachability = Reachability()
    lazy var loadingView: FCLoaderAnimationView = setupLoadingView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

// MARK: - UI

extension FCBaseView {
//    func addFloatingButton() {
//        if Configuration.shared.showChat {
//            let floatingButton = UIButton(type: .system)
//            floatingButton.setImage(Images.zendeskIcon.image()?.withRenderingMode(.alwaysTemplate), for: .normal)
//            floatingButton.tintColor = Configuration.shared.palette.zendeskIconTint.dynamicColor
//            floatingButton.translatesAutoresizingMaskIntoConstraints = false
//            floatingButton.backgroundColor = Configuration.shared.palette.zendeskIconBackground.dynamicColor
//            floatingButton.widthAnchor(equalTo: 60)
//            floatingButton.heightAnchor(equalTo: 60)
//            floatingButton.layer.cornerRadius = 30
//            floatingButton.layer.masksToBounds = true
//            floatingButton.clipsToBounds = true
//            floatingButton.layer.shadowColor = UIColor.black.cgColor
//            floatingButton.layer.shadowOffset = CGSize(width: 0, height: 10)
//            floatingButton.layer.shadowOpacity = 0.4
//            floatingButton.layer.shadowRadius = 2
//            floatingButton.addTarget(self, action: #selector(startZendesk), for: .touchUpInside)
//
//            addSubview(floatingButton)
//
//            floatingButton.bottomAnchor(equalTo: safeBottomAnchor)
//            floatingButton.trailingAnchor(equalTo: trailingAnchor, constant: -20)
//        }
//    }

    @objc private func startZendesk() {
        guard let viewController = Zendesk.instance?.messaging?.messagingViewController() else { return }
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }

        let topVC = UIApplication.fcTopViewController()
        if topVC is AccountStatusViewController {
            topVC?.navigationController?.navigationBar.isHidden = false
        }

        navigationController.show(viewController, sender: self)
    }

    @objc func configureView() {
        // Check for network availability
        if reachability?.connection == Reachability.Connection.none {
            let error = NSError.faaError(Constants.Texts.Errors.reachabilityError)
            if let topVC = UIApplication.fcTopViewController() {
                app.showAlert(Constants.Texts.Errors.reachabilityError, viewController: topVC)
            }
            logError(error)
            return
        }
        setLoadingViewLayout()
    }

    func setLoadingViewLayout() {
        // Adds loadingView on Top
        if let window = UIApplication.shared.windows.last {
            // Search for other loaders views to remove
            let filter = window.subviews.filter({ $0.isKind(of: FCLoaderAnimationView.self) })
            if !filter.isEmpty {
                _ = filter.map({ $0.removeFromSuperview() })
            }
            // Create a new loader view for the current view
            window.addSubview(loadingView)
            loadingView.frame = window.frame
        }
    }

    private func setupLoadingView() -> FCLoaderAnimationView {
        let loaderView = FCLoaderAnimationView()
        /// Custom configurations
        //        loaderView.animationSource = "https://assets5.lottiefiles.com/packages/lf20_lmk0pfms.json"
        //        loaderView.animationSource = "TestLottieLocal"
        //        loaderView.animationSize = 100
                loaderView.backgroundColor = .red.withAlphaComponent(0.5)
        return loaderView
    }
}

// MARK: - Mixpanel functions

extension FCBaseView {
    func trackEvent(eventName: String, _ properties: Properties? = nil) {
        Mixpanel.mainInstance().track(event: eventName, properties: properties)
    }
}
