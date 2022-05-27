//
//  Environment.swift
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Environment definition for development and production
enum Environment: IEnvironment {

    /// development
    case development

    /// production
    case production

    /// base URL for the  environment
    var baseURL: String {
        switch self {
            case .development: return "http://localhost:3000"
            case .production: return "http://localhost:3000"
        }
    }

    /// The default HTTP request headers for the environment
    var headers: [IRequestHeader]? {
        switch self {
            case .development: return [ContentType.applicationJSON]
            case .production: return [ContentType.textJSON]
        }
    }
    
    
    /// Use ``ServiceLogger`` if you don't need some specifics in terms of data from requests and responses
    var logger : ILogger? {
        switch self {
            case .development: return ServiceLogger()
            case .production: return nil
        }
    }
    
}
