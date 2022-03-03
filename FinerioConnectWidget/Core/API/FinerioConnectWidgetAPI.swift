//
//  FinerioAccountAgregationAPI.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import CoreLocation

private let kRequestTimeout = 20.0

public struct FinerioConnectWidgetAPI {
    static let client: HTTPClient = {
        var configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = kRequestTimeout

        return HTTPClient(configuration: configuration)
    }()
}

extension FinerioConnectWidgetAPI {
    public static func countries(completion: @escaping (Result<[Country], MagicLinkAPIError>) -> Void) {
        client.request(.get, APIRoute.countries) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = MagicLinkAPIError(response: response, status: status) ?? .UnknownError
            let countries = [Country](json: response?["data"]) ?? [Country]()
            completion(Result(value: countries, failWith: error))
        }
    }

    public static func banks(country: String, type: String, completion: @escaping (Result<[Bank], MagicLinkAPIError>) -> Void) {
        client.request(.get, APIRoute.banks(country: country, type: type)) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = MagicLinkAPIError(response: response, status: status) ?? .UnknownError
            let banks = [Bank](json: response?["data"]) ?? [Bank]()
            completion(Result(value: banks, failWith: error))
        }
    }

    public static func bankFields(by bankId: String, completion: @escaping (Result<[BankField], MagicLinkAPIError>) -> Void)
    {
        client.request(.get, APIRoute.bankFields(bankId: bankId)) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = MagicLinkAPIError(response: response, status: status) ?? .UnknownError
            let bankFields = [BankField](json: response?["data"]) ?? [BankField]()
            completion(Result(value: bankFields, failWith: error))
        }
    }

    public static func createCredential(credential: Credential, completion: @escaping (Result<CredentialResponse, ApiV2FinerioAPIError>) -> Void)
    {
        let parameters = [
            "widgetId": credential.widgetId,
            "customerId": credential.customerId,
            "customerName": credential.customerName,
            "bankId": credential.bankId,
            "automaticFetching": credential.automaticFetching,
            "state": credential.state,
            "username": credential.username,
            "password": credential.password,
            "securityCode": credential.securityCode,
        ] as [String: Any?]

        client.request(.post, APIRoute.createCredential, parameters: parameters) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = ApiV2FinerioAPIError(response: response, status: status) ?? .UnknownError
            completion(Result(value: CredentialResponse(json: response), failWith: error))
        }
    }

    public static func updateCredentialToken(credentialToken: CredentialToken, completion: @escaping (Result<Bool, ApiV2FinerioAPIError>) -> Void)
    {
        let parameters = [
            "id": credentialToken.id,
            "token": credentialToken.token,
            "widgetId": credentialToken.widgetId,
        ] as [String: Any?]

        client.request(.put, APIRoute.createCredentialToken, parameters: parameters) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = ApiV2FinerioAPIError(response: response, status: status) ?? .UnknownError
            completion(Result(value: true, failWith: error))
        }
    }
}
