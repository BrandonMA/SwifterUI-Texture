//
//  SFImageNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFImageNode: ASImageNode, SFColorStyleProtocol {
    
    // automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    open var automaticallyAdjustsColorStyle: Bool
        
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update colors
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        isUserInteractionEnabled = true
        clipsToBounds = true
        self.backgroundColor = colorStyle.getTextFieldColor()
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = colorStyle.getTextFieldColor()
            updateSubNodesColors()
        }
    }
}
