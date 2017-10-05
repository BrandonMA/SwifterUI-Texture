//
//  SFCollectionController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 06/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFCollectionController: SFViewController<SFCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(SFCollectionNode: SFCollectionNode, automaticallyAdjustsColorStyle: Bool) {
        
        super.init(SFNode: SFCollectionNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.SFNode.delegate = self
        
        self.SFNode.dataSource = self
                
        self.node.backgroundColor = self.SFNode.backgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - ASCollectionDataSource
    
    open func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 0
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { SFCellNode() }
    }
}
























