//
//  post.swift
//
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Combine
import Foundation

public extension INetworkService {
    
    /// Send a post request
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func post<Input : Encodable, Output : Decodable>(
        _ body: Input, with request: IRequest
    ) -> AnyPublisher<Output, ServiceError>
    {
        return withBody(body, with: request)
            .decode(with: self.decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}
