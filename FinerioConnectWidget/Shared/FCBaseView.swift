//
//  FCBaseView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 05/12/21.
//

import UIKit
import Mixpanel

class FCBaseView: UIView {
    //Vars
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
        setLoadingViewLayout()
    }
    
    func setLoadingViewLayout() -> Void {
        //Adds loadingView on Top
        let window = UIApplication.shared.windows.last!
        window.addSubview(loadingView)
        loadingView.frame = window.frame
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
