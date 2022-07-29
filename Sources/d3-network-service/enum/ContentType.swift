//
//  ContentType.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Set of data defining requests headers for content type
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public enum ContentType: String, IRequestHeader {
    case applicationJSON = "application/json"

    case textJSON = "text/json"

    // MARK: - Static

    static let key = "Content-Type"

    // MARK: - Properties

    public var key: String { Self.key }

    public var value: String { rawValue }
}
