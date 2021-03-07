//
//  URL+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

internal extension URL {
    init(staticString: StaticString) {
        self.init(string: String(describing: staticString))!
    }
}
