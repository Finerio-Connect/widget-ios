//
//  String+Extensions.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 07/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

public extension String {
    var isEmptyStr: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }

    func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }

    var isURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))

        for match in matches {
            guard Range(match.range, in: self) != nil else { continue }
            return true
        }

        return false
    }
}
