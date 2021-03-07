//
//  HTTPClient.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

private let kErrorMap: [Int: ResponseType] = [
    400: .badRequest,
    401: .unauthorized,
    403: .forbidden,
    404: .notFound,
    408: .requestTimeOut,
    409: .conflict,
    410: .gone,
    422: .unprocessable,
    426: .upgradeRequired,
    500: .internalError,
    502: .badGateway,
    503: .serviceUnavailable,
    504: .gatewayTimeOut,
    NSURLErrorCancelled: .canceled,
    NSURLErrorTimedOut: .clientTimeOut,
    NSURLErrorNotConnectedToInternet: .notConnected,
]

protocol Routable {
    var url: URL { get }
    var extraHTTPHeaders: [String: String] { get }
}

enum HTTPMethod: String {
    case options, get, head, post, put, patch, delete, trace, connect
}

/// The HTTP response type. The type of this enum is defined by the HTTP Status code or NSURLError
///
/// - succeed:              The request was successfully executed and doesn't need further processing.
/// - badRequest:           The request failed because of a client error
/// - unauthorized:         The request failed because the user is not logged in.
/// - upgradeRequired:      The request failed because the app needs to be upgraded.
/// - forbidden:            The request failed because the user does not have appropriate persmissions.
/// - gone:                 The request failed because the resource is no longer available.
/// - canceled:             The request was canceled by the client.
/// - unprocessable:        The request failed because an error on the information we sent.
/// - notFound:             The request failed because the requested resource wasn't found on the server.
/// - unknownError:         The request failed with an unknown error that shouldn't be retried.
/// - clientTimeOut:        The request failed because there was no response before timeout
/// - notConnected:         The request failed because the user is not connected to the internet
/// - conflict:             The request failed due to a conflict in the request
/// - internalError:        The request failed due to an unexpected condition on the server
/// - badGateway:           The request failed because the server recieved an invalid response from upstream
/// - serviceUnavailable:   The request failed because the server is temporarily unavailable.
/// - requestTimeOut:       The request failed because the client did not produce a request within the time
///                         that the server was prepared to wait
/// - gatewayTimeOut:       The request failed because the server was acting as a gateway or proxy and did not
///                         recieve a response in time
public enum ResponseType {
    case succeed
    case badRequest, unauthorized, upgradeRequired, forbidden, gone
    case canceled, unprocessable, notFound, unknownError, clientTimeOut, notConnected
    case conflict, internalError, badGateway, serviceUnavailable, requestTimeOut, gatewayTimeOut

    init(fromCode code: Int) {
        if code >= 200 && code < 300 {
            self = .succeed
            return
        }

        self = kErrorMap[code] ?? .unknownError
    }
}

final class HTTPClient {
    private let session: URLSession
    required init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
    }

    func request(_ method: HTTPMethod, _ route: Routable, parameters: [String: Any?]? = nil,
                 completion: @escaping (Any?, ResponseType) -> Void)
    {
        let request = urlRequest(method: method, route: route, parameters: parameters)
        logRequest(request)
        let dataTask = session.dataTask(with: request) { data, response, _ in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            let status = ResponseType(fromCode: statusCode)

            self.logResponse(response as? HTTPURLResponse, data)
            let JSON = try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])
            DispatchQueue.main.async {
                completion(JSON, status)
            }
        }

        dataTask.resume()
    }

    private func urlRequest(method: HTTPMethod, route: Routable, parameters: [String: Any?]? = nil) -> URLRequest
    {
        var request = URLRequest(url: route.url)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch let error {
                logError(error as NSError)
            }
        }

        for (key, value) in route.extraHTTPHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        let info = Bundle(for: type(of: self)).infoDictionary
        let version = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
        request.setValue("faa-mobile-sdk:ios::\(version)", forHTTPHeaderField: "User-Agent")

        return request
    }
}

// MARK: - Logs

extension HTTPClient {
    fileprivate func logRequest(_ request: URLRequest?) {
        if Configuration.shared.logLevel != .debug {
            return
        }

        let url = request?.url?.absoluteString ?? "INVALID URL"

        log("******** REQUEST ********")
        log(" - URL:\t" + url)
        log(" - METHOD:\t" + (request?.httpMethod ?? "INVALID REQUEST"))
        logHeaders(request)
        logBody(request)
        log("*************************\n")
    }

    fileprivate func logBody(_ request: URLRequest?) {
        guard
            let body = request?.httpBody,
            let json = try? JSON.dataToJson(body)
        else { return }

        log(" - BODY:\n\(json)")
    }

    fileprivate func logHeaders(_ request: URLRequest?) {
        guard let headers = request?.allHTTPHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    fileprivate func logResponse(_ response: HTTPURLResponse?, _ data: Data?) {
        guard Configuration.shared.logLevel == .debug else { return }

        log("******** RESPONSE ********")
        log(" - URL:\t" + logURL(response))
        log(" - CODE:\t" + "\(response?.statusCode ?? -1)")
        logHeaders(response)
        log(" - DATA:\n" + logData(data))
        log("*************************\n")
    }

    fileprivate func logURL(_ response: HTTPURLResponse?) -> String {
        guard let url = response?.url?.absoluteString else {
            return "NO URL"
        }

        return url
    }

    fileprivate func logHeaders(_ response: HTTPURLResponse?) {
        guard let headers = response?.allHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    fileprivate func logData(_ data: Data?) -> String {
        guard let data = data else {
            return "NO DATA"
        }

        guard let dataJson = try? JSON.dataToJson(data) else {
            return String(data: data, encoding: String.Encoding.utf8) ?? "Error parsing JSON"
        }

        return "\(dataJson)"
    }
}
