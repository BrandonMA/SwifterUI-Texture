//
//  FoodDetailCell.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodDetailCell: ASCellNode {
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.black
        node.text = "2 Eggs"
        node.aligment = .center
        return node
    }()
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "egg")
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layout() {
        super.layout()
        backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 14)
        self.layer.shadowRadius = 23
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        imageNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 0.65)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleNode, getStackSeparator(), imageNode, getStackSeparator()])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stackLayout)
    }
    
}
