//
//  SFCellNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFCellNode: ASCellNode, SFGradientNode, SFBlurredNode, SFDisplayNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
        
    open var automaticallyAdjustsColorStyle: Bool
    
    open var gradient: SFGradient?
    
    open var effect: UIVisualEffect?
    
    open var animator: SFAnimator = SFAnimator()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
        self.animator.view = self.view
    }
    
    open override func layout() {
        super.layout()
        updateColors()
    }
    
    open func updateColors() {
        if automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            updateSubNodesColors()
        }
    }

}









