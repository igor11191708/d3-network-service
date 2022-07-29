//
//  delete.swift
//
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Combine
import Foundation

extension INetwork {
    /// Send a delete request
    /// - Parameters:
    ///  - request - Config based on ``IEnvironment`` to create request
    ///  - parameters - Set of parameters
    /// - Returns: Erased publisher with decoded output and ``ServiceError``  for failure
    func delete<M: Decodable>(with request: IRequest) -> AnyPublisher<M, ServiceError> {
        guard let request = request.urlRequest(with: environment) else { return inputDataErrorPublisher() }

        return doRequest(request)
            .decode(with: decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}
