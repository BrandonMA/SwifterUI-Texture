//
//  SFPagerController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPagerController: SFViewController<SFPagerNode>, ASPagerDataSource {
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(SFPagerNode: SFPagerNode = SFPagerNode(), automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFPagerNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.SFNode.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        self.SFNode.setDataSource(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASPagerDataSource
    
    public func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return 0
    }
    
    public func pagerNode(_ pagerNode: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let node = ASCellNode(viewControllerBlock: { () -> UIViewController in
            return SFViewController<SFDisplayNode>(SFNode: SFDisplayNode(), automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        }, didLoad: nil)
        node.style.preferredSize = pagerNode.bounds.size
        return node
    }
    
}














