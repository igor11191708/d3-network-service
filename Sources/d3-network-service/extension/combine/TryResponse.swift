//
//  TryResponse.swift
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




