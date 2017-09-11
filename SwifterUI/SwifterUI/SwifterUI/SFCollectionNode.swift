//
//  SFCollectionNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 06/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFCollectionNode: ASCollectionNode, SFDisplayNodeColorStyleProtocol {
    
    open var automaticallyAdjustsColorStyle: Bool
    
    public init(automaticallyAdjustsColorStyle: Bool, collectionViewLayout: UICollectionViewLayout) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    public convenience required init(automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            updateSubNodesColors()
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            
            // This is going to loop through every section inside the table node and reload it with the correct color style on the main thread
            for i in 0...self.numberOfSections - 1 {
                for j in 0...self.numberOfItems(inSection: i) {
                    guard let cell = self.nodeForItem(at: IndexPath(row: j, section: i)) as? SFCellNode else { return }
                    print("called")
                    cell.updateColors()
                }
            }
        }
    }
    
}



























