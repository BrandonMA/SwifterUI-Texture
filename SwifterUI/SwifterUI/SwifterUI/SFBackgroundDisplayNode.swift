//
//  SFBackgroundDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFBackgroundDisplayNode: SFDisplayNode {
    
    // MARK: - Instance Methods
    
    open override func updateColors() {
        self.backgroundColor = self.colorStyle.getAlternativeBackgroundColor()
        self.loadingNode.updateColors()
        updateSubNodesColors()
    }
    
}

















