//
//  Environment.swift
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Environments
enum Environment: IEnvironment {

    /// development
    case development

    /// production
    case production

    /// base URL for the  environment
    var baseURL: String {
        switch self {
        case .development: return "http://localhost:3000"
        case .production: return "https://google.com"
        }
    }

    /// The default HTTP request headers for the environment
    var headers: [IRequestHeader]? {
        switch self {
        case .development: return [ContentType.applicationJSON]
        case .production: return [ContentType.textJSON]
        }
    }    
    
}
