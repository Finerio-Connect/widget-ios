//
//  UITextField+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 12/05/21.
//

import UIKit

extension UITextField {
    private func setPasswordToggleImage(_ button: UIButton) {
        let image = isSecureTextEntry ? Images.eyeClosed.image()?.withRenderingMode(.alwaysTemplate) : Images.eyeOpen.image()?.withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = Configuration.shared.palette.mainColor
        button.setImage(image, for: .normal)
    }

    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }

    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry = !isSecureTextEntry

        if let existingText = text, isSecureTextEntry {
            /* When toggling to secure text, all text will' be purged if the user
             continues typing unless we intervene. This is prevented by first
             deleting the existing text and then recovering the original text. */
            deleteBackward()

            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }

        /* Reset the selected text range since the cursor can end up in the wrong
         position after a toggle because the text might vary in width */
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }

        setPasswordToggleImage(sender as! UIButton)
    }

    func setupRightImage(image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        imageView.image = image
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageContainerView.contentMode = .center
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        tintColor = .lightGray
    }
}
