//
//  Zipper.swift
//
//
//  Created by Igor Shelopaev on 06.06.2022.
//

import Combine

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public extension Collection where Element: Publisher, Self.Index == Int {
    /// Zip an array of publishers with the same output and failure
    var zipper: AnyPublisher<[Element.Output], Element.Failure> {
        if let result = chunk(zipInArray).first {
            return result
        }

        return Empty().eraseToAnyPublisher()
    }
}

private extension Collection where Element: Publisher, Self.Index == Int {

    typealias ZippedResult = AnyPublisher<[Element.Output], Element.Failure>
    
    var zipInArray: [ZippedResult] { map { $0.map { [$0] }.eraseToAnyPublisher() } }

    /// Quantize and zip
    /// - Parameter array: Elements we will quantize and zip
    /// - Returns: Zipped elements
    func chunk(_ array: [ZippedResult]) -> [ZippedResult] {

        var r: [ZippedResult] = []
        let p = Publishers.self
        
        //Try quantize by four
        let quantized = stride(from: 0, to: array.count, by: 4).map {
            Array(array[$0 ..< Swift.min($0 + 4, array.count)])
        }

        //Zip quants
        quantized.forEach { a in
            if let f = a.first {
                switch(a.count) {
                    case 2: r += [p.Zip(f, a[1]).map { $0.0 + $0.1 }.eraseToAnyPublisher()]
                    case 3: r += [p.Zip3(f, a[1], a[2]).map { $0.0 + $0.1 + $0.2 }.eraseToAnyPublisher()]
                    case 4: r += [p.Zip4(f, a[1], a[2], a[3]).map { $0.0 + $0.1 + $0.2 + $0.3 }.eraseToAnyPublisher()]
                    default: r += [f]
                }
            }
        }

        if r.count > 1 { r = chunk(r) } // recursion

        return r
    }
}
