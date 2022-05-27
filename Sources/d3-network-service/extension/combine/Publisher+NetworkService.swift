//
//  Publisher+NetworkService.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Combine
import Foundation

extension Publisher where Output == URLSession.DataTaskPublisher.Output {

    /// Transforms all elements from the upstream publisher with a provided error-throwing closure
    /// - Returns: A publisher that uses the provided closure to map elements from the upstream publisher to new elements that it then publishes
    func tryResponse() -> Publishers.TryMap<Self, Data> {
        tryMap { data, response -> Data in

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ServiceError.invalidResponse(response)
            }

            if let httpError = httpResponse.statusCode.mapError {
                throw httpError
            }

            return data
        }
    }
}

extension Publisher where Output == Data {

    /// Decodes the output from the upstream using a specified decoder
    /// - Returns: A publisher that decodes a given type using a specified decoder and publishes the result
    func decode<T: Decodable, D: TopLevelDecoder>(with decoder: D)
        -> Publishers.Decode<Self, T, D>
    {
        decode(type: T.self, decoder: decoder)
    }
}

extension Publisher {

    /// Converts any failure from the upstream publisher into a new ``ServiceError``
    /// - Returns: A publisher that replaces any upstream failure with a new error produced by the transform closure
    func mapServiceError() -> Publishers.MapError<Self, ServiceError> {
        mapError { error -> ServiceError in

            guard let definedError = error as? ServiceError else {
                switch error {
                case is Swift.DecodingError:
                    return .parseError(error.localizedDescription)
                case is URLError:
                    return .urlError(error.localizedDescription)
                default:
                    return .error(error.localizedDescription)
                }
            }

            return definedError
        }
    }
}


