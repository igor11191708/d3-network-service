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
        if let result = chunk(wrapInArray).first {
            return result
        }

        return Empty().erase()
    }
}

private extension Collection where Element: Publisher, Self.Index == Int {

    var wrapInArray: [ZipResult] {
        map { $0.map { [$0] }.erase() }
    }

    /// Quantize and zip try by four
    /// - Parameter array: elements we will quantize and zip
    /// - Returns: zipped elements
    func chunk(_ array: [ZipResult]) -> [ZipResult] {

        var r: [ZipResult] = []

        //Try quantize by four
        let arr = stride(from: 0, to: array.count, by: 4).map {
            Array(array[$0 ..< Swift.min($0 + 4, array.count)])
        }

        //Zip quant
        arr.forEach { a in
            let p = Publishers.self
            let c = a.count

            if let f = a.first {
                if c == 1 {
                    r += [f]
                } else if c == 2 {
                    r += [p.Zip(f, a[1]).map { $0.0 + $0.1 }.erase()]
                } else if c == 3 {
                    r += [p.Zip3(f, a[1], a[2]).map { $0.0 + $0.1 + $0.2 }.erase()]
                } else if c == 4 {
                    r += [p.Zip4(f, a[1], a[2], a[3]).map { $0.0 + $0.1 + $0.2 + $0.3 }.erase()]
                }
            }
        }

        if r.count > 1 { r = chunk(r) } // recursion

        return r
    }
}

fileprivate extension Publisher {
    func erase() -> AnyPublisher<Self.Output, Self.Failure> { eraseToAnyPublisher() }
}



