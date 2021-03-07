//
//  FinerioConnectWidgetAPIURLEncoding.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 14/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

private func components(forKey key: String, value: Any) -> [URLQueryItem] {
    switch value {
    case let array as [Any]:
        return array.map { URLQueryItem(name: key, value: String(describing: $0)) }

    default:
        return [URLQueryItem(name: key, value: String(describing: value))]
    }
}

func finerioAccountAgregationURLEncodedInURL(request: URLRequest, parameters: [String: Any]?) -> (URLRequest, NSError?) {
    guard let parameters = parameters, let url = request.url else {
        return (request, nil)
    }

    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    var mutableURLRequest = request
    let queryItems = parameters
        .sorted { $0.0 < $1.0 }
        .flatMap { components(forKey: $0, value: $1) }
    let existingItems = urlComponents?.queryItems ?? []
    urlComponents?.queryItems = existingItems + queryItems
    mutableURLRequest.url = urlComponents?.url
    return (mutableURLRequest, nil)
}
