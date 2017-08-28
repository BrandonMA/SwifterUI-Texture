//
//  WalkthroughNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class WalkthroughNode<ASMiddleNode>: ZipUpBaseNode where ASMiddleNode: ASDisplayNode {
    
    var middleNode: ASMiddleNode
    
    lazy var bottomButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.cornerRadius = 10
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.textColor = UIColor.white
        return button
    }()
    
    init(with node: ASMiddleNode) {
        self.middleNode = node
        super.init(automaticallyAdjustsColorStyle: false)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
    
    override func didLoad() {
        super.didLoad()
        self.middleNode.cornerRadius = 8
        self.middleNode.backgroundColor = UIColor.white
    }
    
    override func layout() {
        super.layout()
        self.middleNode.layer.shadowColor = UIColor.black.cgColor
        self.middleNode.layer.shadowOpacity = 0.15
        self.middleNode.layer.shadowOffset = CGSize(width: 0, height: 14)
        self.middleNode.layer.shadowRadius = 23
        self.middleNode.layer.shadowPath = UIBezierPath(rect: self.middleNode.bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        topGradientNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 144))
        maskTopGradient(constrainedSize: constrainedSize)
        
        middleNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 48), height: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 48))
        
        bottomButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 32), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let layoutSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [topGradientNode, getStackSeparator(), middleNode, getStackSeparator(), bottomButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: self.titleHeader == "" ? 0: 8, left: 0, bottom: 24, right: 0), child: layoutSpec)
    }
}
