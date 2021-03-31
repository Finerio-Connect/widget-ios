//
//  ImageCaching.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 31/03/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

func main(transaction: @escaping () -> Void) {
    if Thread.isMainThread {
        transaction()
    } else {
        DispatchQueue.main.sync {
            transaction()
        }
    }
}

func mainAsync(transaction: @escaping () -> Void) {
    if Thread.isMainThread {
        transaction()
    } else {
        DispatchQueue.main.async {
            transaction()
        }
    }
}
