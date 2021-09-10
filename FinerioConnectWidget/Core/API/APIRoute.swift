//
//  APIRoute.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

enum APIRoute {
    static var magicLinkBaseURL = URL(staticString: "https://magiclink-api.finerioconnect.com")
    static var apiV2FinerioBaseURL = URL(staticString: Configuration.shared.environment == .sandbox ? "https://api-v2-sandbox.finerio.mx" : "https://api-v2.finerio.mx")

    static let pathCreateCredential = "j2GVbQs3kkcBEttuPWZihSFZkoWnIDwQt2zsGRmQZoitHzMllB"
    static let pathUpdateCredential = "p8U55qGnTMLb7HQzZfCjwcQARtVrrgyt8he9fQKz3KgAFPbAwb"

    case countries
    case banks(country: String, type: String)
    case bankFields(bankId: String)
    case createCredential
    case createCredentialToken
}

extension APIRoute: Routable {
    var url: URL {
        let path: String = {
            switch self {
            case .countries:
                return "/countries"
            case let .banks(country: _country, type: _type):
                return "/banks?country=\(_country)&type=\(_type)"
            case let .bankFields(bankId: _bankId):
                return "/banks/\(_bankId)/fields"
            case .createCredential:
                return APIRoute.pathCreateCredential
            case .createCredentialToken:
                return APIRoute.pathUpdateCredential
            }
        }()

        if path == APIRoute.pathCreateCredential || path == APIRoute.pathUpdateCredential {
            return URL(string: path, relativeTo: APIRoute.apiV2FinerioBaseURL)!
        }

        return URL(string: path, relativeTo: APIRoute.magicLinkBaseURL)!
    }

    var extraHTTPHeaders: [String: String] {
        var extraHeaders: [String: String] = [:]

        extraHeaders["Content-Type"] = "application/json"

        return extraHeaders
    }
}
