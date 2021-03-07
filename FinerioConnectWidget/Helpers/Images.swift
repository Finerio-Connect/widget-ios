//
//  Images.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 16/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

final internal class Images {
    var rawValue: String

    init(_ value: String) {
        rawValue = value
    }

    func image() -> UIImage? {
        return UIImage(named: rawValue, in: Bundle(for: FinerioConnectWidget.self), compatibleWith: nil)
    }
}

extension Images {
    static let otherBanksOff = Images("other_banks_off")
}
