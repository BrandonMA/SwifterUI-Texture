//
//  Extensions.swift
//  Fluid-UI-Framework
//
//  Created by Brandon Maldonado Alonso on 18/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension ASDisplayNode {
    
    // MARK: - Instance Methods
    
    // getStackSeparator: Return a separator for ASStackLayout with flexGrow and flexShrink enabled
    public func getStackSeparator(with flexBasis: CGFloat = 0) -> ASLayoutSpec {
        let separator = ASLayoutSpec() // Create new ASLayoutSpect
        
        if flexBasis != 0 {
            separator.style.flexBasis = ASDimension(unit: ASDimensionUnit.points, value: flexBasis)
            separator.style.flexGrow = 0.0 // Disable flexGrow
            separator.style.flexShrink = 1.0 // Enable flexShrink so the separator shrinks when space is needed
        } else {
            separator.style.flexGrow = 1.0 // Enable flexGrow so the separator expands when free space is available
        }
        
        return separator
    }
}
