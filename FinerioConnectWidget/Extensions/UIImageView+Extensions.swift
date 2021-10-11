//
//  UIImageView+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal extension UIImageView {
    private enum AssociatedKeys {
        static var CurrentTask = "CurrentTask"
    }

    var currentTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.CurrentTask) as? URLSessionDataTask
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.CurrentTask,
                    newValue as URLSessionDataTask?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    func setImage(with url: URL?, placeholder: UIImage? = nil, defaultImage: UIImage? = nil, animated: Bool = true) {
        currentTask?.cancel()

        // Set the placeholder meanwhile the image is downloaded
        image = placeholder

        guard let url = url else { return }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            replaceImage(cachedImage, animated: animated)
        } else {
            currentTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    mainAsync { [weak self] in
                        guard let self = self else { return }
                        self.replaceImage(image, animated: animated)
                    }
                } else {
                    mainAsync { [weak self] in
                        guard let self = self else { return }
                        self.replaceImage(defaultImage!, animated: animated)
                    }
                }
            }
            currentTask?.resume()
        }
    }

    func replaceImage(_ image: UIImage, animated: Bool) {
        guard animated else {
            self.image = image
            return
        }

        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.image = image
        })
    }
}
