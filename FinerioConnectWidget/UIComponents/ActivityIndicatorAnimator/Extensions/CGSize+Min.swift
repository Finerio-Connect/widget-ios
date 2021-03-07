//
//  CGSize+Min.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 26/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

extension CGSize {
    var min: CGFloat {
        return CGFloat.minimum(width, height)
    }
}
