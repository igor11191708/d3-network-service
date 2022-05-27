//
//  IEnvironment.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Protocol for environment **development, production**
@available(iOS 15, macOS 12.0, *)
public protocol IEnvironment {
    
    /// The base URL of the environment
    var baseURL: String { get }
    
    /// The default HTTP request headers for the environment
    var headers: [IRequestHeader]? { get }
        
    /// Use ``ServiceLogger`` if you don't need some specifics in terms of data from requests and responses
    var logger : ILogger? { get }
}

