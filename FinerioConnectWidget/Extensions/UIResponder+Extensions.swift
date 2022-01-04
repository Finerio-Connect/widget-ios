//
//  UIResponder+Extensions.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 05/12/21.
//

import Foundation
import UIKit

extension UIResponder {
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}
