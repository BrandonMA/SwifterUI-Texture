//
//  SFVisualEffectNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 05/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFVisualEffectNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // blurredView: backing UIVisualEffectView wrapped inside a FluidDisplayNode
    public var blurredView: UIVisualEffectView = UIVisualEffectView()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
                
        backgroundColor = UIColor.clear
        
        self.setViewBlock { () -> UIView in
            
            self.blurredView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin] // Add autoresizingMask so the view wraps all over the displayNode
            
            return self.blurredView // set blurredView as the backing view
            
        }
    }
    
    public convenience required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // Initialize FluidVisualEffectNode with an effect
    // - Parameters:
    //   effect: UIVisualEffect that is going to be used
    public convenience init(with effect: UIVisualEffect) {
        self.init(automaticallyAdjustsColorStyle: false)
        self.blurredView.effect = effect
    }
    
    // MARK: - Instance Methods
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.blurredView.effect = self.colorStyle.getCorrectEffect()
            updateSubNodesColors()
        }
    }
}
















