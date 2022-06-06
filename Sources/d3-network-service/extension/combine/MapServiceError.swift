//
//  MapServiceError.swift
//  
//
//  Created by Igor Shelopaev on 05.06.2022.
//

import Combine
import Foundation

extension Publisher {

    /// Converts any failure from the upstream publisher into a new ``ServiceError``
    /// - Returns: A publisher that replaces any upstream failure with a new error produced by the transform closure
    func mapServiceError() -> AnyPublisher<Self.Output, ServiceError> {

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
            
        }.eraseToAnyPublisher()
    }
}
