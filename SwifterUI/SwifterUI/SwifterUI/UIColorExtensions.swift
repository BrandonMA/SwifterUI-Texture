//
//  UIColorExtensions.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 19/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension UIColor {
    
     public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, transparency: CGFloat = 1) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: transparency)
    }
    
    public convenience init(hex: String, transparency: CGFloat = 1) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xff0000) >> 16), green: CGFloat((rgbValue & 0xff00) >> 8), blue: CGFloat(rgbValue & 0xff), transparency: transparency)
    }
}
