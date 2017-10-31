//
//  SFSlider.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFSliderNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open let slider: UISlider
    
    open var value: Float {
        return self.slider.value
    }
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        
        slider = UISlider()
        
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.setViewBlock { () -> UIView in
            self.slider.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            return self.slider
        }
        
        self.style.flexShrink = 1.0
        self.style.flexGrow = 1.0
        self.style.height = ASDimension(unit: .points, value: 48)
    }
    
    // MARK: - Instance Methods
    
    open func add(target: Any?, action: Selector, for event: UIControlEvents) {
        self.slider.addTarget(target, action: action, for: event)
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.tintColor = self.colorStyle.getInteractiveColor()
            self.slider.maximumTrackTintColor = self.colorStyle.getSliderColor()
            updateSubNodesColors()
        }
    }
    
}
