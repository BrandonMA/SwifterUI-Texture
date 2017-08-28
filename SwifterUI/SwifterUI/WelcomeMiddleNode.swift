//
//  WelcomeMiddleNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class WelcomeMiddleNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.font = UIFont.boldSystemFont(ofSize: self.deviceType == .iphone ? 17:21)
        node.text = "Your Nutriologist, Everywere"
        node.color = UIColor.black
        node.aligment = .center
        return node
    }()
    
    lazy var imageNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.image = UIImage(named: "sophie")
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()
    
    lazy var subtitleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.font = UIFont.systemFont(ofSize: self.deviceType == .iphone ? 15:17)
        node.text = "Sophie is going to design a nutritional plan just for you"
        node.color = SFAssets.gray
        node.aligment = .center
        return node
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.flexGrow = 1
        imageNode.style.flexShrink = 1
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 12, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [titleNode, imageNode, subtitleNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stackLayout)
    }
    
}


















