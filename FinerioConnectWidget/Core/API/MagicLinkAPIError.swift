//
//  MagicLinkAPIError.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

public struct MagicLinkAPIError: Error {
    public let error: String
    public let message: String?
    public let status: ResponseType?

    static let UnknownError = MagicLinkAPIError(Constants.Texts.Errors.unknownError)

    init(_ error: String, message: String? = nil) {
        self.message = message
        self.error = error
        self.status = nil
    }

    init?(response: NSDictionary?, status: ResponseType) {
        self.status = status

        if status == .succeed {
            return nil
        }

        self.error = response?["error"] as? String ?? MagicLinkAPIError.UnknownError.error
        self.message = response?["message"] as? String
    }
}
