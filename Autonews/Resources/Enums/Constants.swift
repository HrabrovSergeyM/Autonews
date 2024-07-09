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
    
    public enum Constraints {
        static let buttonPadding: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 8
        
        static let newsfeedCardCornerRadius: CGFloat = 8
        static let newsfeedCardHeight: CGFloat = 120
        
        static let newsfeedCardImageHeight: CGFloat = 120
        static let newsfeedCardImageWidth: CGFloat = 120
    }
}
