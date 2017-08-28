//
//  HomeCell.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class HomeCell: ASCellNode {
    
    // MARK: - Instance Properties
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.black
        node.font = UIFont.boldSystemFont(ofSize: 17)
        node.aligment = .center
        return node
    }()
    
    lazy var subtitleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = SFAssets.gray
        node.font = UIFont.systemFont(ofSize: 15)
        node.aligment = .center
        return node
    }()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.cornerRadius = 8
        self.backgroundColor = UIColor.white
    }
    
    // MARK: - Instance Methods
    
    override func layout() {
        super.layout()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 14)
        self.layer.shadowRadius = 23
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let imageLayout = ASRatioLayoutSpec(ratio: 9/16, child: imageNode)
        
        let labelsLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [titleNode, subtitleNode]))
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [imageLayout, labelsLayout])
        return stackLayout
        
    }
}
