//
//  withBody.swift
//
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Combine
import Foundation

extension INetworkService {

    /// Send a request with a body .put, .post
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func withBody<Input : Encodable>(_ body: Input, with request: IRequest)
        -> AnyPublisher<Data, ServiceError> {

        var httpBody: Data

        /// prepare body
        do { httpBody = try encoder.encode(body) }
        catch {  return inputDataErrorPublisher() }

        guard let request = request.urlRequest(with: environment, body: httpBody) else { return inputDataErrorPublisher() }

        return doRequest(request)
    }
}
