//
//  IEnvironmentProtocol.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Protocol for environment **development, production**
public protocol IEnvironment {
    
    /// The base URL of the environment
    var baseURL: String { get }
}
