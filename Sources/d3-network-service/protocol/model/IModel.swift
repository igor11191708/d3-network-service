//
//  IModel.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Interface for models using as a data to exchange with a server
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public protocol IModel: Codable, Identifiable, Hashable{
    
}
