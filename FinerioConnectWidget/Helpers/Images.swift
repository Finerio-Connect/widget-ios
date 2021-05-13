//
//  Images.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 16/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal final class Images {
    var rawValue: String

    init(_ value: String) {
        rawValue = value
    }

    func image() -> UIImage? {
        return UIImage(named: rawValue, in: Bundle.finerioConnectWidget(), compatibleWith: nil)
    }
}

extension Images {
    static let otherBanksOff = Images("other_banks_off")
    static let otherBanksOn = Images("other_banks_on")
    static let eyeOpen = Images("eye_open")
    static let eyeClosed = Images("eye_closed")
}
