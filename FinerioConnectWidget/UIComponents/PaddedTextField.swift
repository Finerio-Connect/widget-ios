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
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        // alignment for right view and size of the view
        let rightBounds = CGRect(x: bounds.maxX - 42, y: 5, width: 35, height: 35);
        return rightBounds
    }
}
