//
//  IRequestParameter.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Parameter interface
public protocol IRequestParameter{
    
    /// Key field for a param
    var key: String { get }
    
    /// Value field  a param
    var value: Any? { get }
}
