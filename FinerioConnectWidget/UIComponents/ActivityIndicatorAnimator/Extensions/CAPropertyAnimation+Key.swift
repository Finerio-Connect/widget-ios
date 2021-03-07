//
//  CAPropertyAnimation+Key.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 26/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

extension CAPropertyAnimation {
    enum Key: String {
        var path: String {
            return rawValue
        }

        case strokeStart
        case strokeEnd
        case strokeColor
        case rotationZ = "transform.rotation.z"
        case scale = "transform.scale"
    }

    convenience init(key: Key) {
        self.init(keyPath: key.path)
    }
}
