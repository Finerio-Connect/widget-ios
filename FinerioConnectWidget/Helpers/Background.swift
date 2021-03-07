//
//  Background.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 12/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

func runInBackground(_ code: @escaping () -> Void) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async(execute: code)
}

func runOnMainThreadAsync(_ code: @escaping () -> Void) {
    DispatchQueue.main.async(execute: code)
}

func runOnMainThreadSynced(_ code: @escaping () -> Void) {
    DispatchQueue.main.sync(execute: code)
}

func sleep(for seconds: TimeInterval) {
    Thread.sleep(forTimeInterval: seconds)
}
