//
//  SFDetailTextNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 18/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

public class SFDetailLabelNode: SFLabelNode {
    
    // MARK: - Instance Methods
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    override open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.color = colorStyle.getDetailColor()
            updateSubNodesColors()
        }
    }
    
}
