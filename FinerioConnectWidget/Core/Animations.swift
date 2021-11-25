//
//  Animations.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 04/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

final public class Animations: NSObject {
    public var loadingAccountAnimation: String
    public var accountReadyAnimation: String
    public var successAnimation: String
    public var failureAnimation: String

    public init(loadingAccountAnimation: String = AnimationsURLS.loadingAccountAnimation,
                accountReadyAnimation: String = AnimationsURLS.accountReadyAnimation,
                successAnimation: String = AnimationsURLS.successAnimation,
                failureAnimation: String = AnimationsURLS.failureAnimation) {
        self.loadingAccountAnimation = loadingAccountAnimation
        self.accountReadyAnimation = accountReadyAnimation
        self.successAnimation = successAnimation
        self.failureAnimation = failureAnimation
    }
}
