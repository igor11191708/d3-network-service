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

    typealias ZippedResult = AnyPublisher<[Element.Output], Element.Failure>

    /// Zip an array of publishers with the same output and failure
    var zipper: ZippedResult {
        if let result = chunk(wrapInArray).first {
            return result
        }

        return Empty().erase()
    }
}

private extension Collection where Element: Publisher, Self.Index == Int {

    var wrapInArray: [ZippedResult] {
        map { $0.map { [$0] }.erase() }
    }

    /// Quantize and zip
    /// - Parameter array: Elements we will quantize and zip
    /// - Returns: Zipped elements
    func chunk(_ array: [ZippedResult]) -> [ZippedResult] {

        var r: [ZippedResult] = []
        let P = Publishers.self
        
        //Try quantize by four
        let arr = stride(from: 0, to: array.count, by: 4).map {
            Array(array[$0 ..< Swift.min($0 + 4, array.count)])
        }

        //Zip quants
        arr.forEach { a in
            if let f = a.first {
                switch(a.count) {
                    case 2: r += [P.Zip(f, a[1]).map { $0.0 + $0.1 }.erase()]
                    case 3: r += [P.Zip3(f, a[1], a[2]).map { $0.0 + $0.1 + $0.2 }.erase()]
                    case 4: r += [P.Zip4(f, a[1], a[2], a[3]).map { $0.0 + $0.1 + $0.2 + $0.3 }.erase()]
                    default: r += [f]
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
