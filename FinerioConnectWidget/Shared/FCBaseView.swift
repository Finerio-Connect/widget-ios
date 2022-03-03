//
//  FCBaseView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 05/12/21.
//

import UIKit
import Mixpanel

public class FCBaseView: UIView {
    //Vars
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
    
    func setLoadingViewLayout() -> Void {
        //Adds loadingView on Top
        if let window = UIApplication.shared.windows.last {
            // Search for other loaders views to remove
            let filter = window.subviews.filter({$0.isKind(of: FCLoaderAnimationView.self)})
            if !filter.isEmpty {
                let _ = filter.map({$0.removeFromSuperview()})
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
        //        loaderView.backgroundColor = .red.withAlphaComponent(0.5)
        return loaderView
    }
}

// MARK: - Mixpanel functions
extension FCBaseView {
    func trackEvent(eventName: String, _ properties: Properties? = nil) {
        Mixpanel.mainInstance().track(event: eventName, properties: properties)
    }
}
