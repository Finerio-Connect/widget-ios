//
//  Animations.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 04/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

final public class Animations: NSObject {
    public var loadingAnimation: String
    public var accountCreationAnimation: String
    public var successAnimation: String
    public var failureAnimation: String

    public init(loadingAnimation: String = AnimationsURLS.loadingAnimation,
                accountCreationAnimation: String = AnimationsURLS.accountCreationAnimation,
                successAnimation: String = AnimationsURLS.successAnimation,
                failureAnimation: String = AnimationsURLS.failureAnimation) {
        self.loadingAnimation = loadingAnimation
        self.accountCreationAnimation = accountCreationAnimation
        self.successAnimation = successAnimation
        self.failureAnimation = failureAnimation
    }
}
