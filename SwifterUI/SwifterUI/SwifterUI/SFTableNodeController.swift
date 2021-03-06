//
//  SFTableNodeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTableNodeController: SFViewController<SFTableNode>, ASTableDataSource, ASTableDelegate {
        
    // MARK: - Initializers
    
    public init(SFTableNode: SFTableNode = SFTableNode(), automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFTableNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.SFNode.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        self.SFNode.delegate = self
        self.SFNode.dataSource = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - ASTableDataSource
    
    open func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 0
    }
    
    open func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        return { SFCellNode() }
        
    }
}
