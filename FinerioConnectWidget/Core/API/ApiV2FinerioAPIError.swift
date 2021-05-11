//
//  ApiV2FinerioAPIError.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 18/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct ApiV2FinerioAPIError: Error {
    public let error: String
    public let message: String?
    public let status: ResponseType?

    static let UnknownError = ApiV2FinerioAPIError(Constants.Texts.Errors.unknownError)

    init(_ error: String, message: String? = nil) {
        self.error = error
        self.message = message
        status = nil
    }

    init?(response: NSDictionary?, status: ResponseType) {
        self.status = status

        if status == .succeed {
            return nil
        }

        var errorTitle = ""
        var errorCode = ""

        if let errors = response?["errors"] as? [[String: Any]] {
            for error in errors {
                if let title = error["title"] as? String {
                    errorTitle = title
                }

                if let code = error["code"] as? String {
                    errorCode = code
                }
            }
        }

        error = errorTitle
        message = localize(errorCode)
    }
}
