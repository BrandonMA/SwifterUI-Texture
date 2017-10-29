//
//  CGFloatExtensions.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension CGFloat {
    
    // MARK: - Static Methods
    
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}
