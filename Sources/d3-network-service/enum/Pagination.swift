//
//  Pagination.swift
//
//
//  Created by Igor Shelopaev on 25.05.2022.
//

import Foundation


/// Set of parameters for pafination
public enum Pagination: IRequestParameter {

    case page(Int?)

    case pageSize(Int)

    // MARK: - Properties

    public var key: String {
        switch self {
        case .page(_): return "page"
        case .pageSize(_): return "pageSize"
        }
    }

    public var value: Any? {
        switch self {
        case .page(let num): return num
        case .pageSize(let size): return size
        }
    }
    
    public static func getAll(num: Int? = nil, size: Int = 25) -> [Pagination]{
        typealias Page = Pagination
        
        let page: Page = .page(num)
        let pageSize: Page = .pageSize(size)
        
        return [page, pageSize]
    }
}
