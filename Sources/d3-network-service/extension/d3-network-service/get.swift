//
//  get.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Combine
import Foundation

public extension INetworkService {

    /// Send a get request
    /// - Parameters:
    /// - request - Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func get<Output: Decodable>(with request: IRequest) -> AnyPublisher<Output, ServiceError>{
        
        guard let request = request.urlRequest(with: environment) else { return  inputDataErrorPublisher() }
        
        return doRequest(request)
            .decode(with: self.decoder)
            .mapServiceError()
            .eraseToAnyPublisher()
    }

}
