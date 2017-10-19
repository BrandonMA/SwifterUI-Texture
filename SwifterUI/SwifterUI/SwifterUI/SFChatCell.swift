//
//  SFChatNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 09/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFChatCell: SFCellNode {
    
    open var sender = SFMessageSenderType.me
    
    open lazy var textContainerNode: SFChatTextContainer = {
        let node = SFChatTextContainer(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    open lazy var imageContainerNode: SFChatImageContainer = {
        let node = SFChatImageContainer(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    required public init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
    }

    public convenience init(withText text: String, automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.textContainerNode.textLabel.text = text
    }
    
    public convenience init(withImage image: UIImage, automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.imageContainerNode.imageNode.image = image
    }
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.textContainerNode.style.maxWidth = ASDimension(unit: ASDimensionUnit.fraction, value: 2/3)
        self.imageContainerNode.style.maxWidth = ASDimension(unit: ASDimensionUnit.fraction, value: 2/3)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12), child: ASRelativeLayoutSpec(horizontalPosition: self.sender == .me ? .end : .start, verticalPosition: .start, sizingOption: .minimumSize, child: self.imageContainerNode.imageNode.image != nil ? self.imageContainerNode : self.textContainerNode))
    }
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            if sender == .me {
                self.textContainerNode.backgroundColor = self.colorStyle.getInteractiveColor()
                self.textContainerNode.textLabel.textColor = SFAssets.white
                self.imageContainerNode.backgroundColor = self.colorStyle.getInteractiveColor()
            } else if sender == .someone {
                self.textContainerNode.backgroundColor = self.colorStyle.getAlternativeMainColors()
                self.textContainerNode.textLabel.textColor = self.colorStyle.getMainColor()
                self.imageContainerNode.backgroundColor = self.colorStyle.getAlternativeMainColors()
            }
        }
    }
    
}















