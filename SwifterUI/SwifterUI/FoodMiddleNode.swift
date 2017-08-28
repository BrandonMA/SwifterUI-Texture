//
//  FoodMiddleNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodMiddleNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.black
        node.font = self.deviceType == .iphone ? UIFont.boldSystemFont(ofSize: 17):UIFont.boldSystemFont(ofSize: 21)
        node.text = "Banana"
        node.aligment = .center
        return node
    }()
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "banana")
        return node
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        imageNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 0.65)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleNode, getStackSeparator(), imageNode, getStackSeparator()])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stackLayout)
    }
    
}
