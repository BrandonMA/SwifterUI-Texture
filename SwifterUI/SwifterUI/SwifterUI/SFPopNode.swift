//
//  SFPickerNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPopNode: SFDisplayNode {
    
    // MARK: - Instance Methods
    
    lazy var bar: SFPopBarNode = {
        let bar = SFPopBarNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return bar
    }()
    
    var contentNode: SFDisplayNode
    
    // MARK: - Initializers
    
    init(with contentNode: SFDisplayNode, automaticallyAdjustsColorStyle: Bool) {
        self.contentNode = contentNode
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        contentNode.backgroundColor = UIColor.red
    }
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented, call init(with:, automaticallyAdjustsColorStyle:) instead")
    }
    
    // MARK: - Instance Properties
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        bar.style.flexShrink = 0
        contentNode.style.flexGrow = 1
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .start, alignItems: .start, children: [bar, contentNode])
        return stack
    }
    
}


















