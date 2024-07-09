//
//  QueryParameter.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

struct QueryParameter {
    let key: String
    let value: String
    
    static func page(_ value: Int) -> QueryParameter {
        return QueryParameter("page", "\(value)")
    }
    
    static func size(_ value: Int) -> QueryParameter {
        return QueryParameter("size", "\(value)")
    }
    
    init(_ key: String, _ value: Bool) {
        self.key = key
        self.value = "\(value)"
    }
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
}

