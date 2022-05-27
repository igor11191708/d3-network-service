//
//  NetworkService.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
// https://developer.apple.com/documentation/combine/topleveldecoder
//
// Igor was here in 2022:)
//

import Foundation
import Combine

/// Network service to perform GET, POST, PUT, DELETE requests
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public struct NetworkService<D: TopLevelDecoder, E : TopLevelEncoder>: INetworkService where D.Input == Data, E.Output == Data{
   
    /// Logger
    public var logger : ILogger?
    
    /// Decoder
    public var decoder : D
        
    /// Encoder
    public var encoder : E
    
    /// Set of data defining an environment for requests
    public var environment : IEnvironment
    
    /// Init service
    /// - Parameters:
    ///   - decoder: decoder
    ///   - encoder: encoder
    ///   - environment: Set of data defining an environment for requests
    public init(decoder : D, encoder : E, environment : IEnvironment){
        
        self.decoder = decoder
        
        self.encoder = encoder
       
        self.environment = environment
        
        self.logger = environment.logger
    }
    
    /// Init service
    /// - Parameters:
    ///   - decoder: decoder
    ///   - encoder: encoder
    ///   - environment: Set of data defining an environment for requests
    public init(decoder : D = JSONDecoder(), encoder : E = JSONEncoder(), environment : IEnvironment) where D == JSONDecoder, E == JSONEncoder{
        
        self.decoder = decoder
        
        self.encoder = encoder
       
        self.environment = environment
        
        self.logger = environment.logger
    }
}
