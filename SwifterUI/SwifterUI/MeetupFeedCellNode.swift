//
//  MeetupFeedCellNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 18/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MeetupFeedCellNode: SFCellNode {
    
    // MARK: Instance Properties
    
    lazy var photoImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFit
        return imageNode
    }()
    
    lazy var organizerAvatarImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        imageNode.cornerRadius = 17
        imageNode.clipsToBounds = true
        return imageNode
    }()
    
    lazy var organizerNameTextNode: SFLabelNode = SFLabelNode()
    
    lazy var locationLabelNode: SFLabelNode = {
        let label = SFLabelNode()
        label.aligment = .left
        return label
    }()
    
    lazy var timeIntervalSincePost: SFDetailLabelNode = SFDetailLabelNode()
    
    // MARK: Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let organizerAvatarImageNodeDimension = ASDimension(unit: ASDimensionUnit.points, value: 34)
        
        organizerAvatarImageNode.style.preferredLayoutSize = ASLayoutSize(width: organizerAvatarImageNodeDimension, height: organizerAvatarImageNodeDimension)
        
        organizerNameTextNode.style.flexShrink = 1.0
        locationLabelNode.style.flexShrink = 1.0
        locationLabelNode.style.width = ASDimension(unit: ASDimensionUnit.points, value: 200)
        
        let headerTextNodesLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 4, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [organizerNameTextNode, locationLabelNode])
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let headerLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [organizerAvatarImageNode, headerTextNodesLayout, spacer, timeIntervalSincePost])
        
        let headerLayoutWithInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: headerLayout)
        
        let photoImageNodeAspectRatioLayout = ASRatioLayoutSpec(ratio: 9/16, child: photoImageNode)
        
        let finalLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.stretch, children: [headerLayoutWithInsets, photoImageNodeAspectRatioLayout])
        
        return finalLayout
        
    }
    
}

































