//
//  SFCellNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFCellNode: ASCellNode, SFColorStyleProtocol {
    
    // MARK: - Instance Properties
        
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
        
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        updateColors()
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open func updateColors() {
        if automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            updateSubNodesColors()
        }
    }

}
