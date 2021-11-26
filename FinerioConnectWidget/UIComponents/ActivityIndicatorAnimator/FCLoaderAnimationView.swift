//
//  FCLoaderAnimationView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 26/11/21.
//

import Foundation
import Lottie
import UIKit

class FCLoaderAnimationView: UIView {
    var lottieView: LottieView = LottieView()
        
      override init(frame: CGRect) {
        super.init(frame: frame)
          setupView()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
          setupView()
      }
    
    func setupView() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        
        addSubview(lottieView)
        lottieView.heightAnchor(equalTo: 100)
        lottieView.widthAnchor(equalTo: 100)
        lottieView.centerXAnchor(equalTo: centerXAnchor)
        lottieView.centerYAnchor(equalTo: centerYAnchor)
    }
}
