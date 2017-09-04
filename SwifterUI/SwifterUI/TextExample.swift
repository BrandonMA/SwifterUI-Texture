//
//  TextExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 03/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class TextExampleNode: SFDisplayNode {
    
    lazy var label: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: true)
        node.text = "kittens courtesy placekitten.com 😸"
        node.extraAttributes["placekitten.com"] = [NSUnderlineStyleAttributeName: (NSUnderlineStyle.styleSingle.rawValue | NSUnderlineStyle.patternDashDot.rawValue), SFTextAttributeName: SFTextType.button]
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 16, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [label])
        return stack
    }
    
}

class TextExampleController: SFViewController<TextExampleNode> {
    
    init() {
        super.init(SFNode: TextExampleNode(), automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
