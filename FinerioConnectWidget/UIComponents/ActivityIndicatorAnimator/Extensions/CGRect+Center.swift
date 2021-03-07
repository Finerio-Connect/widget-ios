//
//  CGRect+Center.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 26/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
