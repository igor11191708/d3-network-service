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

    func execute<Output: Decodable>(
        with request: IRequest,
        _ parameters: RequestParameters?
    ) -> AnyPublisher<Output, ServiceError>

    func execute<Input : Encodable, Output : Decodable>(
        body: Input,
        with request: IRequest,
        _ parameters: RequestParameters?
    ) -> AnyPublisher<Output, ServiceError>

}

public extension INetworkService {


    /// Send a request
    /// - Parameters:
    ///  - request - Config based on ``IEnvironment`` to create request
    ///  - parameters - Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and
    func execute<Output: Decodable>(
        with request: IRequest,
        _ parameters: RequestParameters? = nil)
        -> AnyPublisher<Output, ServiceError>
    {
        if request.method == .get {
            return get(with: request, parameters)
        }

        if request.method == .delete {
            return delete(with: request)
        }

        return inputDataErrorPublisher()
    }


    /// Send a request
    /// - Parameters:
    ///  - body: The body of the request
    ///  - request - Config based on ``IEnvironment`` to create request
    ///  - parameters - Config based on ``IEnvironment`` to create request
    /// - Returns: Erased publisher with decoded output and
    func execute<Input : Encodable, Output : Decodable>(
        body: Input,
        with request: IRequest,
        _ parameters: RequestParameters? = nil
    ) -> AnyPublisher<Output, ServiceError>
    {
        if request.method == .post {
            return post(body: body, with: request, parameters)
        }
        if request.method == .put {
            return put(body: body, with: request, parameters)
        }

        return inputDataErrorPublisher()
    }

}


extension INetworkService {

    /// Get session
    /// - Returns: Session instance
    func getURLSession() -> URLSession {
        return URLSession.shared
    }

    /// Error publisher for input data error
    /// - Returns: Erased publisher with input data error
    func inputDataErrorPublisher<M>() -> AnyPublisher<M, ServiceError> {
        Fail<M, ServiceError>(error: .inputDataError)
            .eraseToAnyPublisher()
    }
}
