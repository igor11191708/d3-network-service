//
//  ContentType.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation


/// Set of data defining requests headers for content type
public enum ContentType: String, IRequestHeader {
   
    case applicationJSON = "application/json"
    
    case textJSON = "text/json"
    
    // MARK: - Static
    
    static let key = "Content-Type"
    
    // MARK: - Properties
    
    public var key: String { Self.key }
    
    public var value: String { rawValue }
}
