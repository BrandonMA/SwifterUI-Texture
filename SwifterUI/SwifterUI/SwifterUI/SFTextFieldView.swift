//
//  SFTextFieldView.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

open class SFTextFieldView: UITextField {
    
    open var clearButtonColor: UIColor = UIColor.clear {
        didSet {
            layoutSubviews()
        }
    }
    private var cachedColor: UIColor = UIColor.clear
    private var cachedNormalImage: UIImage?
    private var cachedHighlighImage: UIImage?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        tintClearButton() // This is the only place where you can access the clear button
    }
    
    open func tintClearButton() {
        for view in subviews {
            if let button = view as? UIButton {
                if cachedNormalImage == nil || cachedColor != clearButtonColor {
                    
                    cachedNormalImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                    
                    if #available(iOS 11.0, *) {
                        self.cachedHighlighImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                    } else {
                        self.cachedHighlighImage = button.image(for: .highlighted)?.tint(color: self.tintColor!, alpha: 1)
                    }
                    
                    cachedColor = clearButtonColor
                }
                
                guard let cachedNormalImage = cachedNormalImage, let cachedHighlighImage = cachedHighlighImage else { return }
                button.setImage(cachedNormalImage, for: .normal)
                button.setImage(cachedHighlighImage, for: .highlighted)
            }
        }
    }
}
