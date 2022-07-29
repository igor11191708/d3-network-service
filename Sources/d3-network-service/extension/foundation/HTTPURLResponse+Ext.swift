//
//  HTTPURLResponse+Ext.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//
// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
//

import Foundation

extension HTTPURLResponse {
    typealias StatusCode = Int
}

extension HTTPURLResponse.StatusCode {
    /// informational responses
    static let informational = 100 ... 199

    /// successful responses
    static let successful = 200 ... 299

    /// redirect responses
    static let redirect = 300 ... 399

    /// client error responses
    static let clientError = 400 ... 499

    /// server error responses
    static let serverError = 500 ... 599
}

extension HTTPURLResponse.StatusCode {
    /// Define an error type according the status code
    func mapError(_ httpURLResponse: HTTPURLResponse) -> ServiceError? {
        switch self {
        case 200 ... 299: return nil
        case 400 ... 499: return ServiceError.clientError(httpURLResponse)
        case 500 ... 599: return ServiceError.serverError(httpURLResponse)
        default: return ServiceError.http(httpURLResponse)
        }
    }
}
