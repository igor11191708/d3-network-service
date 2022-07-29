//
//  ServiceLogger.swift
//
//
//  Created by Igor Shelopaev on 27.05.2022.
//

import Foundation

/// Standard loger
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public struct ServiceLogger: ILogger {
    // MARK: - Life circle

    public init() {}

    // MARK: - API

    /// Log requests
    /// - Parameter request: `URLRequest`
    public func log(_ request: URLRequest) {
        if let httpMethod = request.httpMethod,
           let url = request.url
        {
            print("\(httpMethod) '\(url.absoluteString)'")
            headers(request)
            body(request)
        }
    }

    /// Log responses
    /// - Parameter response: `URLResponse`
    public func log(_ response: URLResponse) {
        if let response = response as? HTTPURLResponse {
            statusCode(response)
        }
    }

    // MARK: - Private

    /// Log http status code
    /// - Parameter urlResponse: `HTTPURLResponse`
    private func statusCode(_ urlResponse: HTTPURLResponse) {
        if let url = urlResponse.url {
            print("Status code: \(urlResponse.statusCode) '\(url.absoluteString)'")
        }
    }

    /// Log http headers
    /// - Parameter urlRequest: `URLRequest`
    private func headers(_ urlRequest: URLRequest) {
        if let allHTTPHeaderFields = urlRequest.allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                print("Http headers: \(key) : \(value)")
            }
        }
    }

    /// Log http body
    /// - Parameter urlRequest: `URLRequest`
    private func body(_ urlRequest: URLRequest) {
        if let body = urlRequest.httpBody,
           let str = String(data: body, encoding: .utf8)
        {
            print("Http body: \(str)")
        }
    }
}
