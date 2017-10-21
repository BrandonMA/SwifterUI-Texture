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
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFAnimatable
    
    open lazy var animator: SFAnimator = SFAnimator(with: self, animations: [.none])
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
    }
    
    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.shouldHaveAlternativeColors == false ? self.colorStyle.getBackgroundColor() : self.colorStyle.getAlternativeBackgroundColor()
            self.view.indicatorStyle = self.colorStyle.getScrollIndicatorStyle()
            updateSubNodesColors()
        }
    }
    
}
