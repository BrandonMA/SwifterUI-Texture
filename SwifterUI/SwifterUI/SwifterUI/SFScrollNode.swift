//
//  SFScrollNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFScrollNode: ASScrollNode, SFDisplayNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var animator: SFAnimator = SFAnimator()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        self.animator.view = self.view
    }
    
    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            self.view.indicatorStyle = self.colorStyle.getScrollIndicatorStyle()
            updateSubNodesColors()
        }
    }
    
}
