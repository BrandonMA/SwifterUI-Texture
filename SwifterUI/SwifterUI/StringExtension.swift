//
//  StringExtension.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 03/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import Foundation

extension String {
    
    func nsRange(of string: String) -> NSRange {
        let text = self as NSString
        return text.range(of: string)
    }
}
