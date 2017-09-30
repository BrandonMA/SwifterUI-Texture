//
//  DateExtensions.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import Foundation

extension Date {
    public static func today(with format: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
