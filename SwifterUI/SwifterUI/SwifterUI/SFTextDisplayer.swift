//
//  SFTextDisplayer.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 23/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFTextDisplayer: SFTextContainer {
    
    // MARK: - Instance Methods
    
    func updateTextColor()
}

extension SFTextDisplayer where Self: SFDisplayNodeColorStyle {
    
    // MARK: - Instance Methods
    
    public func updateTextColor() {
        // If extraAttributes are bigger than 0 then check for each attribute inside the array
        if textTypeAttributes.count != 0 {
            for var attributes in self.textTypeAttributes {
                if let type = attributes.value[SFTextTypeName] {
                    if type == .button {
                        extraAttributes[attributes.key] = [NSAttributedStringKey.foregroundColor : colorStyle.getInteractiveColor()]
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
