//
//  PaddedTextField.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 17/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class PaddedTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0.5, left: 8, bottom: 0.5, right: 8)
    private var lblError: UILabel = UILabel()
    private let rightButton = UIButton(type: .custom)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.textRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.placeholderRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = super.editingRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    override required init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    func commonInit() {
//        rightButton.setImage(Images.eyeClosed.image(), for: .normal)
//        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
//        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//
//        rightViewMode = .always
//        rightView = rightButton
//        isSecureTextEntry = true
//    }
//
//    @objc func toggleShowHide(button: UIButton) {
//        toggle()
//    }
//
//    func toggle() {
//        isSecureTextEntry = !isSecureTextEntry
//        if isSecureTextEntry {
//            rightButton.setImage(Images.eyeClosed.image(), for: .normal)
//        } else {
//            rightButton.setImage(Images.eyeOpen.image(), for: .normal)
//        }
//    }
}
