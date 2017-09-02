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
    
    // blurredNode: background node of SFDisplayNode used to blur your current context while loading
    public lazy var blurredNode: SFVisualEffectNode = {
        let visualNode = SFVisualEffectNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return visualNode
    }()
    
    // activityNode: SFActivityNode use to show the user a loading animation while he waits
    public lazy var activityNode: SFActivityNode = {
        let node = SFActivityNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
        
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool){
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    public convenience required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // layoutSpecThatFits: Layout all subnodes
    override open func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        blurredNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.fraction, value: 1))
        
        let activityNodeLayout = ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: activityNode)
        
        return ASOverlayLayoutSpec(child: blurredNode, overlay: activityNodeLayout)
    }
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            backgroundColor = UIColor.clear
            updateSubNodesColors()
        }
    }
}
