//
//  Decode.swift
//  
//
//  Created by Igor Shelopaev on 05.06.2022.
//

import Combine
import Foundation

extension Publisher {

    /// Decodes the output from the upstream using a specified decoder
    /// - Returns: A publisher that decodes a given type using a specified decoder and publishes the result
    func decode<T, D>(with decoder: D) -> AnyPublisher<T, Error> where T: Decodable, D: TopLevelDecoder, Self.Output == D.Input, Output == Data {

        decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

}
