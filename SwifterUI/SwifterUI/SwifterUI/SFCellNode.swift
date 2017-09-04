//
//  SFCellNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFCellNode: ASCellNode, SFGradientProtocol, SFBlurredProtocol {
    
    // MARK: - Instance Properties
        
    open var automaticallyAdjustsColorStyle: Bool
    
    open var gradient: SFGradient?
    
    public var effect: UIVisualEffect?
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    public convenience override required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        updateColors()
    }
}

extension SFCellNode: SFDisplayNodeColorStyleProtocol {
    open func updateColors() {
        if automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            updateSubNodesColors()
        }
    }
}








