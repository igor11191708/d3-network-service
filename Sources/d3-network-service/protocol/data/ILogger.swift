//
//  ILogger.swift
//
//
//  Created by Igor Shelopaev on 27.05.2022.
//

import Foundation

/// Logger interface
public protocol ILogger {

    
    /// Log requests
    func log(_ request: URLRequest)

    
    /// Log responses
    func log(_ response: URLResponse)

}
