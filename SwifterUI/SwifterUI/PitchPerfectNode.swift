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
        button.setImage(UIImage(named: "Record"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
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
        button.setImage(UIImage(named: "Stop"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        recordButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .points, value: 80), height: ASDimension(unit: .points, value: 80))
        stopButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .points, value: 80), height: ASDimension(unit: .points, value: 80))
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 32, justifyContent: .center, alignItems: .center, children: [recordButton, recordingLabel, stopButton])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stack)
    }
}

















