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
    
    override open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = colorStyle.getInteractiveColor()
            updateSubNodesColors()
        }
    }
    
}
