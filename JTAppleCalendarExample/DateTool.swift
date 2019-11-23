//
//  DateTool.swift
//  JTAppleCalendarExample
//
//  Created by Seokho on 2019/11/23.
//  Copyright © 2019 Seokho. All rights reserved.
//

import Foundation

extension Date {
    func convertString(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = LocalList.korea
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

extension String {
    func convertDate(_ dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = LocalList.korea
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent

        let date = dateFormatter.date(from: self)

        return date
    }
}
enum LocalList {
    static let korea = Locale(identifier: "ko-KR")
}

