//
//  IModel.swift
//  
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation

/// Interface for models using as a data to exchange with a server
@available(iOS 15, macOS 12.0, *)
public protocol IModel: Codable, Identifiable, Hashable{
    
}
