//
//  VerticallyTextView.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 26/11/21.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

// Model to support plain and linked text
struct TextWithLink {
    var fullPlainText: String
    var linkedTextPhrase: String?
    var urlSource: String?
}

class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
}
