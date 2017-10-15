//
//  FoursquareCell.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoursquareCell: SFCellNode {
    
    // MARK: - Instance Properties
    
    lazy var titleLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.isLayerBacked = true
        return label
    }()
    
    lazy var subtitleLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        label.isLayerBacked = true
        return label
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [titleLabel, subtitleLabel])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: stackLayout)
    }
    
}
