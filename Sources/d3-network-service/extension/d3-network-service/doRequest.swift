//
//  doRequest.swift
//
//
//  Created by Igor Shelopaev on 27.05.2022.
//

import Combine
import Foundation

extension INetworkService {

    /// Performe request
    /// - Parameter request: Request data
    /// - Returns: Erased publisher with raw output and  ``ServiceError``  for failure
    func doRequest(_ request: URLRequest) -> AnyPublisher<Data, ServiceError> {

        let urlSession = getURLSession()

        logger?.log(request)

        return urlSession
            .dataTaskPublisher(for: request)
            .tryResponse(logger)
            .mapServiceError()
            .eraseToAnyPublisher()
    }

    /// Send a request with a body .put, .post
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func doRequest<Input : Encodable>(
        body: Input,
        with request: IRequest,
        _ parameters: RequestParameters? = nil) -> AnyPublisher<Data, ServiceError> {

        var httpBody: Data

        /// prepare body
        do {
            httpBody = try encoder.encode(body)
        }
        catch {
            return inputDataErrorPublisher()
        }

        guard let request = request.urlRequest(with: environment, body: httpBody, parameters) else { return inputDataErrorPublisher() }

        return doRequest(request)
    }

}
