//
//  PitchPerfectEditorNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 18/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class PitchPerfectEditorNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    lazy var slowButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "Slow"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var fastButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "Fast"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var highPitchButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "HighPitch"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var lowPitchButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "LowPitch"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var echoPitchButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "Echo"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var reverbPitchButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "Reverb"), for: .normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
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
        slowButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        fastButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        highPitchButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        lowPitchButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        echoPitchButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        reverbPitchButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1/2), height: ASDimension(unit: .fraction, value: 1))
        stopButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .points, value: 80), height: ASDimension(unit: .points, value: 80))
        
        let firstStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [slowButton, fastButton])
        firstStack.style.flexGrow = 1.0
        firstStack.style.flexShrink = 1.0
        firstStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let secondStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [highPitchButton, lowPitchButton])
        secondStack.style.flexGrow = 1.0
        secondStack.style.flexShrink = 1.0
        secondStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let thirdStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [echoPitchButton, reverbPitchButton])
        thirdStack.style.flexGrow = 1.0
        thirdStack.style.flexShrink = 1.0
        thirdStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let finalStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .center, children: [firstStack, secondStack, thirdStack, stopButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32), child: finalStack)
    }
}
