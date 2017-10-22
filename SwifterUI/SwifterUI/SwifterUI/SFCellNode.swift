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
    
    // MARK: - SFDisplayNodeColorStyle
        
    open var automaticallyAdjustsColorStyle: Bool
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFGradientNode
    
    open var gradient: SFGradient?
    
    // MARK: - SFBlurredNode
    
    open var effect: UIVisualEffect?
    
    // MARK: - SFAnimatable
    
    open lazy var animator: SFAnimator = SFAnimator(with: self, animations: [])
    
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
    }
    
    open override func layout() {
        super.layout()
        updateColors()
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if automaticallyAdjustsColorStyle == true {
            if self.effect != nil {
                self.backgroundColor = UIColor.clear
            } else {
                self.backgroundColor = self.shouldHaveAlternativeColors == false ? self.colorStyle.getBackgroundColor() : self.colorStyle.getAlternativeBackgroundColor()
            }
            updateSubNodesColors()
        }
    }

}









