//
//  SFTextFieldView.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

open class SFTextFieldView: UITextField {
    
    var clearButtonColor: UIColor = UIColor.clear {
        didSet {
            layoutSubviews()
        }
    }
    var cachedColor: UIColor = UIColor.clear
    var cachedImage: UIImage?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        tintClearButton() // This is the only place where you can access the clear button
    }
    
    open func tintClearButton() {
        for view in subviews {
            if let button = view as? UIButton {
                if cachedImage == nil {
                    cachedImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                } else if cachedColor != clearButtonColor {
                    cachedImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                    cachedColor = clearButtonColor
                }
                
                guard let cachedImage = cachedImage else { return }
                button.setImage(cachedImage, for: .normal)
            }
        }
    }
}
