//
//  Zipper.swift
//
//
//  Created by Igor Shelopaev on 06.06.2022.
//

import Combine
import Foundation


@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public extension Collection where Element: Publisher, Self.Index == Int {

    typealias ZipResult = AnyPublisher<[Element.Output], Element.Failure>
    
    /// Zip an array of publishers with the same output and failure
    var zipper: ZipResult {

        if isEmpty { return Empty().eraseToAnyPublisher() }

        let c: [ZipResult] = map { $0.map { [$0] }.eraseToAnyPublisher() }

        return chunked(c).first ?? Empty().eraseToAnyPublisher() //despite that we checked empty decided to do it safe
    }

}

// MARK: - Private

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
private extension Collection where Element: Publisher, Self.Index == Int {
    
    /// Quantize and zip try by four
    /// - Parameter array: elements we will quantize and zip
    /// - Returns: zipped elements
    func chunked(_ array: [ZipResult]) -> [ZipResult] {

        var r: [ZipResult] = []

        let arr = stride(from: 0, to: array.count, by: 4).map {
            Array(array[$0 ..< Swift.min($0 + 4, array.count)])
        }

        arr.forEach { a in
            if let f = a.first {
                if a.count == 1 {
                    r += [f]
                } else if a.count == 2 {
                    r += [Publishers.Zip(f, a[1]).map { $0.0 + $0.1 }.eraseToAnyPublisher()]
                } else if a.count == 3 {
                    r += [Publishers.Zip3(f, a[1], a[2]).map { $0.0 + $0.1 + $0.2 }.eraseToAnyPublisher()]
                } else if a.count == 4 {
                    r += [Publishers.Zip4(f, a[1], a[2], a[3]).map { $0.0 + $0.1 + $0.2 + $0.3 }
                    .eraseToAnyPublisher()]
                }
            }
        }

        if r.count > 1 { r = chunked(r) }

        return r
    }
}


