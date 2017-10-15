//
//  PitchPerfectNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class PitchPerfectNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    lazy var recordButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setBackgroundImage(UIImage(named: "Record"), for: UIControlState.normal)
        return button
    }()
    
    lazy var recordingLabel: SFLabelNode = {
        let label = SFLabelNode()
        label.text = "Tap to record"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var stopButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setBackgroundImage(UIImage(named: "Stop"), for: UIControlState.normal)
        return button
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        recordButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 128), height: ASDimension(unit: ASDimensionUnit.points, value: 128))
        stopButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 64), height: ASDimension(unit: ASDimensionUnit.points, value: 64))
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 32, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [recordButton, recordingLabel, stopButton])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stack)
    }
    
}

















