//
//  StringExtensions.swift
//  Fluid-UI-Framework
//
//  Created by Brandon Maldonado Alonso on 02/07/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension String {
    
    // MARK: - Instance Methods
    
    // insert: Insert a string on the given index
    // - Parameters:
    //   string: String that you want to insert
    //   index: Index where you want to insert the string
    public mutating func insert(string: String, at index: Index) {
        var newString = String(self[..<index])
        newString.append(string)
        newString.append(String(self[index...]))
        self = newString
    }
    
    public func nsRange(of string: String) -> NSRange {
        let text = self as NSString
        return text.range(of: string)
    }

    
}
