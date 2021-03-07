//
//  StrokeColorAnimation.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal final class StrokeColorAnimation: CAKeyframeAnimation {
    override init() {
        super.init()
    }

    init(colors: [CGColor], duration: Double) {
        super.init()

        keyPath = "strokeColor"
        values = colors
        self.duration = duration
        repeatCount = .greatestFiniteMagnitude
        timingFunction = .init(name: .easeInEaseOut)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
