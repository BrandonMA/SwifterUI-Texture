//
//  SFLoadingNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 10/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLoadingNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // blurredNode: background node of FluidLoadingNode used to blur your current context while loading
    public lazy var blurredNode: SFVisualEffectNode = {
        let visualNode = SFVisualEffectNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return visualNode
    }()
    
    // activityNode: FluidActivityNode use to show the user a loading animation while he waits
    public lazy var activityNode: SFActivityNode = {
        let node = SFActivityNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
        
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public required init(automaticallyAdjustsColorStyle: Bool){
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // layoutSpecThatFits: Layout all subnodes
    override open func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        blurredNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.fraction, value: 1))
        
        let activityNodeLayout = ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: activityNode)
        
        return ASOverlayLayoutSpec(child: blurredNode, overlay: activityNodeLayout)
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            backgroundColor = UIColor.clear
            updateSubNodesColors()
        }
    }
}
