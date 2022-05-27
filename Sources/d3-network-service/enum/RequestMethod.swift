//
//  RequestMethod.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Http methods
@available(iOS 15, macOS 12.0, *)
public enum RequestMethod: String {

    case get = "GET"

    case post = "POST"

    case put = "PUT"

    case delete = "DELETE"
    
}
