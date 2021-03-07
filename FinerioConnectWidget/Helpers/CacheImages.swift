//
//  CacheImages.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 16/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

final internal class CacheImages {
    func setCache(url: String?) {
        DispatchQueue.global().async {
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            let urlToString = url.absoluteString as NSString

            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                }
            }
        }
    }
}
