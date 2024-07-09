//
//  Constants.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

public enum Constants {
    static let mainLink = "https://webapi.autodoc.ru/api/news"
    
    public enum QueryKeys: String {
        case page = "page"
        case size = "size"
    }
}
