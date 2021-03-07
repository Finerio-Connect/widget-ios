//
//  Bundle+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 12/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

internal extension Bundle {
    class func finerioConnectWidget() -> Bundle {
        Bundle(for: FinerioConnectWidget.self)
            .url(forResource: "FinerioConnectWidget", withExtension: "bundle")
            .flatMap(Bundle.init(url:))
            ?? Bundle(for: FinerioConnectWidget.self)
    }
}
