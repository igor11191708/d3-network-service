//
//  IRequest.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation
import Combine

/// Defines an interface to create `URLRequest`
public protocol IRequest {

    /// The path that will be appended to API's base URL.
    var path: String { get }

    /// The HTTP method.
    var method: RequestMethod { get }

    /// The HTTP headers
    var headers: [IRequestHeader] { get }

    /// The request parameters used for query parameters
    var parameters: [IRequestParameter] { get }

}

extension IRequest {
    
    /// Create a URLRequest
    /// - Parameter environment: The environment where `URLRequest` happens
    /// - Parameter body:  Passing data
    /// - Returns: An optional `URLRequest`
    func urlRequest(with environment: IEnvironment, body: Data) -> URLRequest? {

        guard var request = urlRequest(with: environment) else {
            return nil
        }

        request.httpBody = body

        return request
    }

    /// Create a URLRequest
    /// - Parameter environment: The environment where `URLRequest` happens
    /// - Returns: An optional `URLRequest`.
    func urlRequest(with environment: IEnvironment) -> URLRequest? {

        guard let url = url(with: environment.baseURL) else {
            return nil
        }

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue

        headers.forEach { request.addValue($0) }

        return request
    }

    // MARK: - Private
    
    /// Create a URL
    /// - Parameter baseURL: The base URL string
    /// - Returns: An optional `URL`.
    private func url(with baseURL: String) -> URL? {

        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        urlComponents.path = urlComponents.path + path

        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    /// Create list of parameters `URLQueryItem`
    private var queryItems: [URLQueryItem]? {

        return parameters.map { (item) -> URLQueryItem in
            let valueString = String(describing: item.value ?? "")
            return URLQueryItem(name: item.key, value: valueString)
        }
    }

}

public extension IRequest {
    /// Default heders set
    var headers: [IRequestHeader] { [] }

    /// Default parameters set
    var parameters: [IRequestParameter] { [] }
}
