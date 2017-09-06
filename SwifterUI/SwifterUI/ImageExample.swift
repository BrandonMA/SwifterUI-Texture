//
//  ImageExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 04/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class ImageExampleNode: SFDisplayNode {
    
    lazy var imageNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.image = UIImage(named: "image")
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()
    
    lazy var label: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: true)
        node.text = "kittens courtesy placekitten.com 😸"
        node.extraAttributes["placekitten.com"] = [NSUnderlineStyleAttributeName: (NSUnderlineStyle.styleSingle.rawValue | NSUnderlineStyle.patternDashDot.rawValue), SFTextAttributeName: SFTextType.button]
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 320), height: ASDimension(unit: ASDimensionUnit.points, value: 568))
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 16, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [label, imageNode])
        return stack
    }    
}

class ImageExampleController: SFViewController<ImageExampleNode> {
    
    init() {
        super.init(SFNode: ImageExampleNode(), automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
