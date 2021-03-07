//
//  FAAError.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 27/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

extension NSError {
    class func unexpectedError(debugMessage: String? = nil, code: Int = Constants.ErrorCodes.Unknown) -> NSError {
        let error = faaError(fLocaleErrorUnexpected, debugMessage: debugMessage, code: code)

        return error
    }

    class func faaError(_ message: String? = nil, debugMessage: String? = nil, code: Int = Constants.ErrorCodes.Unknown) -> NSError {
        var userInfo: [String: String] = [:]

        if message != nil {
            userInfo[Configuration.FinerioConnectWidgetErrorKey] = message
        }

        if debugMessage != nil {
            userInfo[Configuration.FinerioConnectWidgetErrorDebugKey] = debugMessage
        }

        let error = NSError(
            domain: Configuration.ErrorDomain,
            code: code,
            userInfo: userInfo
        )

        return error
    }

    func message() -> String {
        guard let message = userInfo[Configuration.FinerioConnectWidgetErrorKey] as? String else {
            return fLocaleErrorUnexpected
        }

        return message
    }
}
