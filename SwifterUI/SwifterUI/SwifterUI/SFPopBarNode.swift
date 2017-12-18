//
//  SFPopBarNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPopBarNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open override var tintColor: UIColor! {
        didSet {
            dismissButton.tintColor = tintColor
            middleLabel.textColor = tintColor
            saveButton.textColor = tintColor
        }
    }
    
    lazy var dismissButton: SFDismissButton = {
        let button = SFDismissButton(automaticallyAdjustsColorStyle: false)
        button.tintColor = self.tintColor
        return button
    }()
    
    lazy var middleLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: false)
        label.textColor = self.tintColor
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var saveButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.textColor = self.tintColor
        button.text = LocalizedString.shared.getSave()
        button.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    // MARK: - Instance Methods
    
    open override func layout() {
        super.layout()
        self.style.width = ASDimension(unit: .fraction, value: 1)
        
    }
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [dismissButton, middleLabel, saveButton])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: stack)
    }
    
    open override func updateColors() {
        super.updateColors()
        if self.automaticallyAdjustsColorStyle == true {
            self.addShadow(color: self.colorStyle.getSeparatorColor(), offSet: CGSize(width: 0, height: 1), radius: 1, opacity: 1)
        }
    }
    
}
