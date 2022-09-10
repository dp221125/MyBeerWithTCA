//
//  BaseTargetType.swift
//  MyBeer
//
//  Created by Milkyo on 2022/09/10.
//

import Foundation

public protocol BaseTargetType {
    var request: URLRequest { get }
    var queryParameter: [String: Any]? { get }
    var path: String { get }
}

public extension BaseTargetType {
    var baseUrl: String {
        return "api.punkapi.com"
    }

    var header: [String: String] {
        return [
            "Content-Type": "application/json",
        ]
    }

    var url: URL {
        var components = URLComponents()

        components.scheme = "https"
        components.host = baseUrl
        components.path = path
        components.queryItems = []

        queryParameter?.forEach {
            components.queryItems?.append(URLQueryItem(
                name: $0.key,
                value: "\($0.value)"
            ))
        }

        if let url = components.url {
            return url
        } else {
            return URL(string: "")!
        }
    }

    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}
