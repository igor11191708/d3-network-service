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
    func then<T: Decodable>(_ publisher: AnyPublisher<T, ServiceError>) -> Publishers.FlatMap<AnyPublisher<T, ServiceError>, Self> {

        self.flatMap { value in publisher }
    }
    
    
    
    /// Chain publishers with predicate logic
    /// - Parameters:
    ///   - predicate: Analyze previous result
    ///   - publisher: New publisher
    /// - Returns: Chained publishers
    func then<T: Decodable>(
        ifTrue  : @escaping (Self.Output) -> Bool,
        _ publisher: AnyPublisher<T, ServiceError>
    ) -> Publishers.FlatMap<AnyPublisher<T, ServiceError>, Self> {
        
        self.flatMap{
            if ifTrue($0) == false {
                return Fail<T, ServiceError>(error: .chainingError)
                    .eraseToAnyPublisher()
            }
            
            return publisher
        }
    }
    
}
