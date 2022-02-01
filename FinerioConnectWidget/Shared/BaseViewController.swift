//
//  BaseViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

internal class BaseViewController: UIViewController {
    weak var coordinator: Coordinator?
    weak var context: Context?
    
    override open func viewDidLoad() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        view.backgroundColor = .clear
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getConstraintConstant(firstValue: Double, secondValue: Double, value: Double = 0.0) -> CGFloat {
        if UIDevice.current.screenType == .iPhones_5_5s_5c_SE || UIDevice.current.screenType == .iPhones_6_6s_7_8 {
            return CGFloat(firstValue - value)
        }
        
        return CGFloat(secondValue)
    }
    
    func showAlert(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: literal(.companyName), message: message, preferredStyle: .alert)
        
        let actionLater = UIAlertAction(title: fLocaleAlertButtonOk, style: .cancel, handler: nil)
        alert.addAction(actionLater)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
