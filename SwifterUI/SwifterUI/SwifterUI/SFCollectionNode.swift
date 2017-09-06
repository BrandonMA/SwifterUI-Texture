//
//  SFCollectionNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 06/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFCollectionNode: ASCollectionNode, SFDisplayNodeColorStyleProtocol {
    
    public var automaticallyAdjustsColorStyle: Bool
    
    public init(automaticallyAdjustsColorStyle: Bool, collectionViewLayout: UICollectionViewLayout) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    public convenience required init(automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    public func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            updateSubNodesColors()
            self.backgroundColor = self.colorStyle.getAlternativeBackgroundColor()
            
            // This is going to loop through every section inside the table node and reload it with the correct color style on the main thread
            for i in 0...self.numberOfSections - 1 {
                let indexSet = IndexSet(integer: i)
                self.reloadSections(indexSet) // Reload all the sections
            }
        }
    }
    
}



























