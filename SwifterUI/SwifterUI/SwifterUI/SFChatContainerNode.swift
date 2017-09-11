//
//  SFChatContainerNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFChatContainerNode: SFDisplayNode {
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        cornerRadius = 8
        clipsToBounds = true
    }
}

open class SFChatTextContainer: SFChatContainerNode {
    
    open lazy var textLabel: SFLabelNode = {
        let textLabel = SFLabelNode(automaticallyAdjustsColorStyle: false)
        textLabel.aligment = .left
        textLabel.text = ""
        textLabel.font =  UIFont.systemFont(ofSize: 17)
        return textLabel
    }()
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: self.textLabel))
    }
}

open class SFChatImageContainer: SFChatContainerNode {
    
    open lazy var imageNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.contentMode = .scaleAspectFit
        imageNode.image = nil
        return imageNode
    }()
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var layout = ASRatioLayoutSpec(ratio: 9/16, child: self.imageNode)
        if let image = self.imageNode.image {
            layout = ASRatioLayoutSpec(ratio: image.size.height/image.size.width, child: self.imageNode)
        }
        return layout
    }
    
}
