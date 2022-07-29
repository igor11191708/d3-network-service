//
//  URLRequest+Ext.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

extension URLRequest {
    /// Add pair of data defining a header
    /// - Parameter header: header conforms to ``IRequestHeader``
    mutating func addValue(_ header: IRequestHeader) {
        addValue(header.value, forHTTPHeaderField: header.key)
    }
}
