//
//  SFImageNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageNode: ASImageNode {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool
        
    // MARK: - Initializers

    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        isUserInteractionEnabled = true
        clipsToBounds = true
        self.backgroundColor = colorStyle.getTextFieldColor()
    }
    
    public convenience override required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
}

extension SFImageNode: SFDisplayNodeColorStyleProtocol {
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = colorStyle.getTextFieldColor()
            updateSubNodesColors()
        }
    }
    
}





