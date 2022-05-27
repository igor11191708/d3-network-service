//
//  ServiceError.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Set of errors defined in the service
@available(iOS 15, macOS 12.0, *)
public enum ServiceError: Error, Hashable {
  
    /// input data could not be formed
    case inputDataError
    
    /// url error
    case urlError(String)
    
    /// The server response was invalid (unexpected format)
    case invalidResponse(URLResponse)
    
    /// The request was rejected: 400-499
    case clientError
    
    /// A server error 500...599
    case serverError
    
    ///status code error
    case http
    
    /// There was an error parsing the data
    case parseError(String)
    
    /// Unknown error
    case error(String)
    

}


