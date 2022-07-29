//
//  post.swift
//
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Combine
import Foundation

extension INetwork {
    /// Send a post request
    /// - Parameters:
    ///  - body - The body of the request
    ///  - request - Config based on ``IEnvironment`` to create request
    ///  - parameters - Set of parameters
    /// - Returns: Erased publisher with decoded output and
    func post<Input: Encodable, Output: Decodable>(
        body: Input,
        with request: IRequest,
        _ parameters: RequestParameters? = nil
    ) -> AnyPublisher<Output, ServiceError> {
        return doRequest(body: body, with: request, parameters)
            .decode(with: decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}
