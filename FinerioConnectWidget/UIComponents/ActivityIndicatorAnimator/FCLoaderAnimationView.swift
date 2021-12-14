//
//  FCLoaderAnimationView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 26/11/21.
//

import Foundation
import Lottie
import UIKit

public final class FCLoaderAnimationView: UIView {
    // Components
    private var animationView: AnimationView = AnimationView()
    
    // Vars
    private var isSettingLocalAnimation = false
    public var animationSource: String = Configuration.shared.animations.loadingAnimation {
        didSet {
            setupAnimationLoadingView()
        }
    }

    internal var animationSize: CGFloat = 120 {
        didSet {
            setAnimationSize()
        }
    }
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

// MARK: - Public functions
extension FCLoaderAnimationView {
    @objc public func start() -> Void {
        self.isHidden = false
        animationView.play()
    }
    
    @objc public func stop() -> Void {
        animationView.stop()
        self.isHidden = true
    }
}

// MARK: - UI
extension FCLoaderAnimationView {
    private func configureView() {
        backgroundColor = .black.withAlphaComponent(0.6)
        setupAnimationLoadingView()
        
        addSubview(animationView)
        setAnimationSize()
        setLayoutAnimationView()
        self.isHidden = true
    }
    
    private func setupAnimationLoadingView() {
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        animationView.animation = nil
        
        if animationSource.isURL {
            onlineAnimation(with: animationSource)
        }
        else {
            localAnimation(with: animationSource)
        }
    }
}

// MARK: - Layout
extension FCLoaderAnimationView {
    private func setAnimationSize() -> Void {
        // To prevent duplicated constraints.
        animationView.removeConstraints(animationView.constraints)
        
        animationView.heightAnchor(equalTo: animationSize)
        animationView.widthAnchor(equalTo: animationSize)
    }
    
    private func setLayoutAnimationView() -> Void {
        animationView.centerXAnchor(equalTo: centerXAnchor)
        animationView.centerYAnchor(equalTo: centerYAnchor)
    }
}

// MARK: - Inputs
extension FCLoaderAnimationView {
    private func onlineAnimation(with source: String) {
        isSettingLocalAnimation = false
        
        if let animationURL = URL(string: source) {
            Animation.loadedFrom(url: animationURL, closure: { [weak self] animation in
                DispatchQueue.main.async {
                    // To prevent overwriting animation
                    if !(self?.isSettingLocalAnimation ?? false) {
                        self?.animationView.animation = animation
                        self?.animationView.play()
                        self?.animationView.loopMode = .loop
                    }
                }
            }, animationCache: nil)
        }
    }
    
    private func localAnimation(with source: String) {
        isSettingLocalAnimation = true
        
        if let animationSourcePath = Bundle.main.path(forResource: source, ofType: "json") {
            let animation = Animation.filepath(animationSourcePath)
            animationView.animation = animation
            animationView.play()
            animationView.loopMode = .loop
        }
    }
}
