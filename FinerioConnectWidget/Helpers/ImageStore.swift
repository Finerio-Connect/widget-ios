//
//  ImageStore.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

final internal class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}
