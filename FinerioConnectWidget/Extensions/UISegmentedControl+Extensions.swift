//
//  UISegmentedControl+Extensions.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 22/02/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func removeBackgroundShadow() {
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(self.numberOfSegments-1)  {
                    let backgroundSegmentView = self.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
    
}
