//
//  get.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Combine
import Foundation

extension INetwork {

    /// Send a get request
    /// - Parameters:
    ///  - request - Config based on ``IEnvironment`` to create request
    ///  - parameters - Set of parameters
    /// - Returns: Erased publisher with decoded output and ``ServiceError``  for failure
    func get<Output: Decodable>(
        with request: IRequest,
        _ parameters: RequestParameters? = nil) -> AnyPublisher<Output, ServiceError>{

        guard let request = request.urlRequest(with: environment, parameters) else { return inputDataErrorPublisher()
        }

        return doRequest(request)
            .decode(with: self.decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}
