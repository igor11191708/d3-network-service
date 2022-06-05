//
//  Publisher+NetworkService.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Combine
import Foundation

/// URLSession.DataTaskPublisher.Output is
/// (data: Data, response: URLResponse)
extension Publisher where Output == URLSession.DataTaskPublisher.Output {


    typealias ResponseData = Publishers.TryMap<Self, Data>

    /// Transforms all elements from the upstream publisher with a provided error-throwing closure
    /// - Returns: A publisher that uses the provided closure to map elements from the upstream publisher to new elements that it then publishes
    func tryResponse(_ logger: ILogger? = nil) -> ResponseData {

        tryMap { data, response -> Data in

            logger?.log(response)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ServiceError.invalidResponse(response)
            }

            if let httpError = httpResponse.statusCode.mapError(httpResponse) {
                throw httpError
            }

            return data
        }
    }
}

extension Publisher {

    /// Decodes the output from the upstream using a specified decoder
    /// - Returns: A publisher that decodes a given type using a specified decoder and publishes the result
    func decode<T, D>(with decoder: D) -> Publishers.Decode<Self, T, D> where T: Decodable, D: TopLevelDecoder, Self.Output == D.Input, Output == Data {

        decode(type: T.self, decoder: decoder)
    }


    typealias MappedError = Publishers.MapError<Self, ServiceError>

    /// Converts any failure from the upstream publisher into a new ``ServiceError``
    /// - Returns: A publisher that replaces any upstream failure with a new error produced by the transform closure
    func mapServiceError() -> MappedError {

        mapError { error -> ServiceError in

            guard let definedError = error as? ServiceError else {
                switch error {
                case is Swift.DecodingError:
                    return .parseError(error.localizedDescription)
                case is URLError:
                    return .urlError(error.localizedDescription)
                default:
                    return .error(error as NSError)
                }
            }

            return definedError
        }
    }
}

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

