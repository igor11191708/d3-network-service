//
//  IRequestHeader.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Header interface
public protocol IRequestHeader {
        
    /// Key field for a header
    var key: String { get }
        
    /// Value field  a header
    var value: String { get }
    
}
