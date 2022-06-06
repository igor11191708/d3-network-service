//
//  Then.swift
//
//
//  Created by Igor Shelopaev on 05.06.2022.
//

import Combine
import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public extension Publisher {

    /// Create serial chain with two publishers
    /// - Parameter publisher: Publisher to chain
    /// - Returns: New publisher
    func then<T: Decodable>(_ publisher: AnyPublisher<T, ServiceError>) -> AnyPublisher<T, ServiceError> where Failure == ServiceError{

        flatMap { value in publisher }
            .eraseToAnyPublisher()
    }



    /// Chain publishers with predicate logic
    /// - Parameters:
    ///   - predicate: Analyze previous result
    ///   - publisher: New publisher
    /// - Returns: Chained publishers
    func then<T: Decodable>(
        ifTrue: @escaping (Self.Output) -> Bool,
        _ publisher: AnyPublisher<T, ServiceError>
    ) ->
    AnyPublisher<T, ServiceError> where Failure == ServiceError{

        flatMap { (value : Self.Output) -> AnyPublisher<T, ServiceError> in
            if ifTrue(value) == false {
                return Fail<T, ServiceError>(error: .chainingError)
                    .eraseToAnyPublisher()
            }

            return publisher
        }.eraseToAnyPublisher()
    }

}

