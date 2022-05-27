//
//  ILogger.swift
//
//
//  Created by Igor Shelopaev on 27.05.2022.
//

import Foundation

/// Logger interface
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public protocol ILogger {

    
    /// Log requests
    func log(_ request: URLRequest)

    
    /// Log responses
    func log(_ response: URLResponse)

}
