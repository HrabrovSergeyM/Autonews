//
//  Endpoint.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

enum Endpoint {
    case mainLink
    
    var rawValue: String {
        switch self {
        case .mainLink: return ""
        }
    }
    
    func url(with parameters: [QueryParameter] = []) -> URL? {
        var components = URLComponents(string: Constants.mainLink + self.rawValue)
        if !parameters.isEmpty {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return components?.url
    }
    
    func withParameters(_ parameters: [QueryParameter]) -> URL? {
        return self.url(with: parameters)
    }
}
