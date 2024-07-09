//
//  String.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    func toDisplayFormat(fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss", toFormat: String = "dd.MM.yyyy") -> String? {
        guard let date = self.toDate(format: fromFormat) else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
}
