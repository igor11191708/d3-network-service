//
//  ILogger.swift
//
//
//  Created by Igor Shelopaev on 27.05.2022.
//

import Foundation

/// Logger interface
@available(iOS 15, macOS 12.0, *)
public protocol ILogger {

    
    /// Log requests
    func log(_ request: URLRequest)

    
    /// Log responses
    func log(_ response: URLResponse)

}
