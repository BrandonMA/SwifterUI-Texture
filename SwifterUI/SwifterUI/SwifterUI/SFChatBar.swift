//
//  SFChatBar.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFChatBar: SFDisplayNode {
    
    open lazy var imageButton: ASImageNode = {
        let node = ASImageNode()
        return node
    }()
    
    open lazy var textField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        textField.placeholder = LocalizedString.shared.getType() + "..."
        textField.leftPadding = 12
        return textField
    }()
    
    open lazy var sendButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        button.text = LocalizedString.shared.getSend()
        button.font = UIFont.boldSystemFont(ofSize: 17)
        return button
    }()
    
    open override func didLoad() {
        super.didLoad()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.20
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 15
    }
    
    open override func layout() {
        super.layout()
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageButton.style.height = ASDimension(unit: ASDimensionUnit.points, value: 24)
        imageButton.style.width = ASDimension(unit: ASDimensionUnit.points, value: 32)
        
        textField.style.flexGrow = 1.0
        textField.style.flexShrink = 1.0
        textField.style.height = ASDimension(unit: ASDimensionUnit.points, value: 40)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [imageButton, textField, sendButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: stackLayout)
    }
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            super.updateColors()
            SFAssets.imageOfCameraIcon.tint(color: self.colorStyle.getPlaceholderColor(), alpha: 1, handler: { (image) in
                Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                    self.imageButton.image = image
                })
            })
            
        }
    }
}
