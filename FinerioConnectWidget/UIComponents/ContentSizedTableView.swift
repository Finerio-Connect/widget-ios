//
//  ContentSizedTableView.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 27/04/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
