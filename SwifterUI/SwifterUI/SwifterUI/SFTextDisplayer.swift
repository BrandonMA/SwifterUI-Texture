//
//  SFTextDisplayer.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFTextDisplayer: SFTextContainer {
    func updateTextColor()
}

extension SFTextDisplayer where Self: SFDisplayNodeColorStyle {
    
    public func updateTextColor() {
        // If extraAttributes are bigger than 0 then check for each attribute inside the array
        if extraAttributes.count != 0 {
            for var attributes in extraAttributes {
                // If the current value of the array(that is another array) contain SFTextTypeName and is SFTextType
                if let type = attributes.value[SFTextTypeName] as? SFTextType {
                    if type == .button {
                        attributes.value[NSForegroundColorAttributeName] = colorStyle.getInteractiveColor()
                        extraAttributes[attributes.key] = attributes.value
                    }
                }
            }
        }
    }
    
    public func setAttributedText() {
        if let textDisplayer = self as? SFLabelNode {
            textDisplayer.attributedText = self.mutableAttributedText
        } else if let textDisplayer = self as? SFEditableTextNode {
            textDisplayer.attributedText = self.mutableAttributedText
        }
    }
}
