//
//  put.swift
//
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Combine
import Foundation

extension INetworkService {

    /// Send a put request
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func put<Input : Encodable, Output : Decodable>(
        body: Input,
        with request: IRequest,
        _ parameters : RequestParameters? = nil
    )-> AnyPublisher<Output, ServiceError>
    {
        return doRequest(body: body, with: request, parameters)
            .decode(with: self.decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}

