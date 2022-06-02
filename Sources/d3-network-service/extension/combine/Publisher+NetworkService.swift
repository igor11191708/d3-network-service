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
    func tryResponse(_ logger : ILogger? = nil) -> ResponseData {

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
    func decode<T, D>(with decoder: D) -> Publishers.Decode<Self, T, D> where T : Decodable, D : TopLevelDecoder, Self.Output == D.Input, Output == Data {

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


