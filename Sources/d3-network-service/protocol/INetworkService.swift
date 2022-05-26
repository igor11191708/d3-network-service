//
//  INetworkService.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Combine
import Foundation


/// Define interface of service to create network requests
public protocol INetworkService {

    associatedtype IDecoder: TopLevelDecoder where IDecoder.Input == Data

    /// Decoder
    var decoder: IDecoder { get }

    associatedtype IEncoder: TopLevelEncoder where IEncoder.Output == Data

    /// Encoder
    var encoder: IEncoder { get }

    /// Set of data defining an environment for requests
    var environment: IEnvironment { get }

// MARK: - Methods

    /// Send a get request
    /// - Parameters:
    /// - request - Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func get<Output: Decodable>(with request: IRequest) -> AnyPublisher<Output, ServiceError>

    /// Send a post request
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func post<Input : Encodable, Output : Decodable>(
        _ body: Input, with request: IRequest
    ) -> AnyPublisher<Output, ServiceError>

    /// Send a put request
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request: Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func put<Input : Encodable, Output : Decodable>(
        _ body: Input, with request: IRequest
    ) -> AnyPublisher<Output, ServiceError>

    /// Send a delete request
    /// - Parameters:
    /// - request - Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and  ``ServiceError``  for failure
    func delete<M: Decodable>(with request: IRequest) -> AnyPublisher<M, ServiceError>

}


private extension INetworkService {

    /// Get session
    /// - Returns: Session instance
    func getURLSession() -> URLSession {
        return URLSession.shared
    }
}

extension INetworkService {

    /// Performe request
    /// - Parameter request: Request data
    /// - Returns: Erased publisher with raw output and  ``ServiceError``  for failure
    func doRequest(_ request: URLRequest) -> AnyPublisher<Data, ServiceError> {
        let urlSession = getURLSession()

        return urlSession
            .dataTaskPublisher(for: request)
            .tryResponse()
            .mapServiceError()
            .eraseToAnyPublisher()
    }

    
    /// Error publisher for input data error
    /// - Returns: Erased publisher with input data error
    func inputDataErrorPublisher<M>() -> AnyPublisher<M, ServiceError> {
        Fail<M, ServiceError>(error: .inputDataError)
            .eraseToAnyPublisher()
    }
}
