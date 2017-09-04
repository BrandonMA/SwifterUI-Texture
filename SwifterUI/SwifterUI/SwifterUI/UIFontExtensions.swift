//
//  UIFontExtensions.swift
//  Fluid-UI-Framework
//
//  Created by Brandon Maldonado Alonso on 11/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public extension UIFont {
    
    // MARK: - Static Methods
    
    // systemFont: Return system font with system font size
    public static func systemFont() -> UIFont {
        return UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
}
