//
//  SFPagerNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPagerNode: ASPagerNode, SFNodeColorStyle {
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool = false
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        let layout = ASPagerFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: CGRect.zero, collectionViewLayout: layout, layoutFacilitator: nil)
    }
    
    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
        automaticallyManagesSubnodes = true
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.shouldHaveAlternativeColors == false ? self.colorStyle.getBackgroundColor() : self.colorStyle.getAlternativeBackgroundColor()
            updateSubNodesColors()
        }
    }
    
}
