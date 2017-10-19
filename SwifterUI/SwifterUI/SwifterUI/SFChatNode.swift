//
//  SFChatNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 10/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFChatNode: SFDisplayNode {
    
    open var isKeyboardVisible: Bool = false
    open var keyboardHeight: CGFloat = 0
    
    open lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    open lazy var collectionNode: SFCollectionNode = {
        let collectionNode = SFCollectionNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle, collectionViewLayout: self.collectionLayout)
        return collectionNode
    }()
    
    open lazy var bottomBar: SFChatBar = {
        let bar = SFChatBar(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return bar
    }()
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        collectionNode.style.width = ASDimension(unit: .fraction, value: 1)
        collectionNode.style.flexGrow = 1
        
        bottomBar.style.width = ASDimension(unit: .fraction, value: 1)
        
        let stackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [collectionNode, bottomBar])

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0), child: stackLayout)
        
    }
    
    
}




















