//
//  UIBezierPath+Circle.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 26/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }
}
