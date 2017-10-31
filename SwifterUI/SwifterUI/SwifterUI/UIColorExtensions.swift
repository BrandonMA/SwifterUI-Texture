//
//  UIColorExtensions.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 19/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension UIColor {
    
    // MARK: - Initializers
    
     public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
    public convenience init(hex: String, alpha: CGFloat = 1) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(r: CGFloat((rgbValue & 0xff0000) >> 16), g: CGFloat((rgbValue & 0xff00) >> 8), b: CGFloat(rgbValue & 0xff), alpha: alpha)
    }
    
    // MARK: - Static Methods
    
    public static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: alpha)
    }
    
    public static func hexValue(r: CGFloat, g: CGFloat, b: CGFloat) -> String {
        return String(format:"%02X", Int(r)) + String(format:"%02X", Int(g)) + String(format:"%02X", Int(b))
    }
}









