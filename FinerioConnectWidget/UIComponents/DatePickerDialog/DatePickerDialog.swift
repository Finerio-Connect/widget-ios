//
//  DatePickerDialog.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 22/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    static let buttonTapped = #selector(DatePickerDialog.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerDialog.deviceOrientationDidChange)
}

open class DatePickerDialog: UIView {
    public typealias DatePickerCallback = (Date?) -> Void

    // MARK: - Constants

    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 7
    private let kDoneButtonTag: Int = 1

    // MARK: - Views

    private var dialogView: UIView!
    private var titleLabel: UILabel!
    open var datePicker: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!

    // MARK: - Variables

    private var defaultDate: Date?
    private var datePickerMode: UIDatePicker.Mode?
    private var callback: DatePickerCallback?
    var showCancelButton: Bool = false
    var locale: Locale?

    private var textColor: UIColor!
    private var buttonColor: UIColor!
    private var font: UIFont!

    private var container: UIView?
    private lazy var gradient = CAGradientLayer(layer: self.layer)

    // MARK: - Dialog initialization

    @objc public init(
        textColor: UIColor? = nil,
        buttonColor: UIColor? = nil,
        font: UIFont = .boldSystemFont(ofSize: 15),
        locale: Locale? = nil,
        showCancelButton: Bool = true
    ) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.textColor = textColor ?? DPDColors.text
        self.buttonColor = buttonColor ?? DPDColors.accent
        self.font = font
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }

    @available(*, unavailable)
    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        dialogView = createContainerView()

        dialogView?.layer.shouldRasterize = true
        dialogView?.layer.rasterizationScale = UIScreen.main.scale

        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        dialogView?.layer.opacity = 0.5
        dialogView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)

        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        if let dialogView = dialogView {
            addSubview(dialogView)
        }
    }

    /// Handle device orientation changes
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        frame = UIScreen.main.bounds
        let dialogSize = CGSize(width: 300, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)
        dialogView.frame = CGRect(
            x: (UIScreen.main.bounds.size.width - dialogSize.width) / 2,
            y: (UIScreen.main.bounds.size.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        )
    }

    /// Create the dialog view, and animate opening the dialog
    open func show(
        _ title: String,
        doneButtonTitle: String = "Done",
        cancelButtonTitle: String = "Cancel",
        defaultDate: Date = Date(),
        minimumDate: Date? = nil, maximumDate: Date? = nil,
        datePickerMode: UIDatePicker.Mode = .dateAndTime,
        callback: @escaping DatePickerCallback
    ) {
        titleLabel.text = title
        doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton { cancelButton.setTitle(cancelButtonTitle, for: .normal) }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        datePicker.datePickerMode = self.datePickerMode ?? UIDatePicker.Mode.date
        datePicker.date = self.defaultDate ?? Date()
        datePicker.maximumDate = maximumDate
        datePicker.minimumDate = minimumDate
        if let locale = self.locale { datePicker.locale = locale }

        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }

        /* Add dialog to main window */
        guard let window = UIApplication.shared.windows.first else { fatalError() }
        window.addSubview(self)
        window.bringSubviewToFront(self)
        window.endEditing(true)

        NotificationCenter.default.addObserver(
            self,
            selector: .deviceOrientationDidChange,
            name: UIDevice.orientationDidChangeNotification, object: nil
        )

        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView?.layer.opacity = 1
                self.dialogView?.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        )
    }

    /// Dialog close animation then cleaning and removing the view from the parent
    private func close() {
        let currentTransform = dialogView.layer.transform

        let startRotation = (value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)

        dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        dialogView.layer.opacity = 1

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.transform = transform
                self.dialogView.layer.opacity = 0
            }
        ) { _ in
            for v in self.subviews {
                v.removeFromSuperview()
            }

            self.removeFromSuperview()
            self.setupView()
        }
    }

    /// Creates the container view here: create the dialog, then add the custom content and buttons
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: 300, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)

        // For the black background
        frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        // This is the dialog's container; we attach the custom content and the buttons to this one
        let container = UIView()
        self.container = container
        container.frame = CGRect(
            x: (screenSize.width - dialogSize.width) / 2,
            y: (screenSize.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        )

        // First, we style the dialog to match the iOS8 UIAlertView >>>
        gradient.frame = container.bounds
        gradient.colors = DPDColors.gradientBackground

        let cornerRadius = kCornerRadius
        gradient.cornerRadius = cornerRadius
        container.layer.insertSublayer(gradient, at: 0)

        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = DPDColors.separator.cgColor
        container.layer.borderWidth = 1
        container.layer.shadowRadius = cornerRadius + 5
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowPath = UIBezierPath(
            roundedRect: container.bounds,
            cornerRadius: container.layer.cornerRadius
        ).cgPath

        // There is a line above the button
        let yPosition = container.bounds.size.height - kDefaultButtonHeight - kDefaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(
            x: 0,
            y: yPosition,
            width: container.bounds.size.width,
            height: kDefaultButtonSpacerHeight
        ))

        lineView.backgroundColor = DPDColors.separator
        container.addSubview(lineView)

        // Title
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.font = font.withSize(17)
        container.addSubview(titleLabel)

        datePicker = configuredDatePicker()
        container.addSubview(datePicker)

        // Add the buttons
        addButtonsToView(container: container)

        return container
    }

    fileprivate func configuredDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.setValue(textColor, forKeyPath: "textColor")
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = 300
        datePicker.frame.size.height = 216
        return datePicker
    }

    /// Add buttons to container
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2

        var leftButtonFrame = CGRect(
            x: 0,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        var rightButtonFrame = CGRect(
            x: buttonWidth,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - kDefaultButtonHeight,
                width: buttonWidth,
                height: kDefaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight

        if showCancelButton {
            cancelButton = UIButton(type: .system)
            cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            cancelButton.setTitleColor(buttonColor, for: .normal)
            cancelButton.setTitleColor(buttonColor, for: .highlighted)
            cancelButton.titleLabel?.font = font.withSize(14)
            cancelButton.layer.cornerRadius = kCornerRadius
            cancelButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            container.addSubview(cancelButton)
        }

        doneButton = UIButton(type: .system)
        doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        doneButton.tag = kDoneButtonTag
        doneButton.setTitleColor(buttonColor, for: .normal)
        doneButton.setTitleColor(buttonColor, for: .highlighted)
        doneButton.titleLabel?.font = font.withSize(14)
        doneButton.layer.cornerRadius = kCornerRadius
        doneButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        container.addSubview(doneButton)
    }

    @objc func buttonTapped(sender: UIButton) {
        if sender.tag == kDoneButtonTag {
            callback?(datePicker.date)
        } else {
            callback?(nil)
        }

        close()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        container?.layer.borderColor = DPDColors.separator.cgColor
        gradient.colors = DPDColors.gradientBackground
    }
}

internal enum DPDColors {
    static var gradientBackground: [CGColor] {
        if #available(iOS 13.0, *) {
            return [UIColor.systemGray4.cgColor, UIColor.systemGray5.cgColor, UIColor.systemGray5.cgColor]
        } else {
            return [UIColor(hex: "DADADE")!.cgColor, UIColor(hex: "EAEAEE")!.cgColor, UIColor(hex: "DADADE")!.cgColor]
        }
    }

    static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3
        } else {
            return UIColor(hex: "#D1D1D6")!
        }
    }

    static var text: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor(hex: "3993F8")!
        }
    }

    static var accent: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return UIColor(hex: "3993F8")!
        }
    }
}
