//
//  ActivityIndicatorView.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 26/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

@IBDesignable
public class ActivityIndicatorView: UIView {
    @IBInspectable
    public var color: UIColor = .red {
        didSet {
            indicator.strokeColor = color.cgColor
        }
    }

    @IBInspectable
    public var lineWidth: CGFloat = 5.0 {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    private let indicator = CAShapeLayer()
    private let animator = ActivityIndicatorAnimator()

    private var isAnimating = false

    convenience init() {
        self.init(frame: .zero)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        indicator.strokeColor = color.cgColor
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        layer.addSublayer(indicator)
    }
}

extension ActivityIndicatorView {
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 80)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = bounds

        let diameter = bounds.size.min - indicator.lineWidth
        let path = UIBezierPath(center: bounds.center, radius: diameter / 2)
        indicator.path = path.cgPath
    }
}

extension ActivityIndicatorView {
    public func startAnimating() {
        guard !isAnimating else { return }

        animator.addAnimation(to: indicator)
        isAnimating = true
    }

    public func stopAnimating() {
        guard isAnimating else { return }

        animator.removeAnimation(from: indicator)
        isAnimating = false
    }
}
