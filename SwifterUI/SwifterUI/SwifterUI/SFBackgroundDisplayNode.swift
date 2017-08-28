//
//  SFBackgroundDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFBackgroundDisplayNode: SFDisplayNode {
    
    // MARK: - Instance Methods
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open override func updateColors() {
        self.backgroundColor = self.colorStyle.getAlternativeBackgroundColor()
        self.loadingNode.updateColors()
        updateSubNodesColors()
    }
    
}

















