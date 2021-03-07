//
//  PaddedTextField.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 17/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class PaddedTextField: UITextField {
    fileprivate let padding = UIEdgeInsets(top: 0.5, left: 8, bottom: 0.5, right: 8)
    fileprivate var lblError:UILabel                        = UILabel()

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
}
