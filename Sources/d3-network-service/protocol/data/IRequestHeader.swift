//
//  IRequestHeader.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Header interface
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public protocol IRequestHeader {
        
    /// Key field for a header
    var key: String { get }
        
    /// Value field  a header
    var value: String { get }
    
}
