//
//  Extensions.swift
//  Fluid-UI-Framework
//
//  Created by Brandon Maldonado Alonso on 18/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public extension ASDisplayNode {
    
    // MARK: - Instance Methods
    
    // getStackSeparator: Return a separator for ASStackLayout with flexGrow and flexShrink enabled
    public func getStackSeparator(with flexBasis: CGFloat = 0) -> ASLayoutSpec {
        let separator = ASLayoutSpec() // Create new ASLayoutSpect
        
        if flexBasis != 0 {
            separator.style.flexBasis = ASDimension(unit: ASDimensionUnit.points, value: flexBasis)
            separator.style.flexGrow = 0.0 // Disable flexGrow
        } else {
            separator.style.flexGrow = 1.0 // Enable flexGrow so the separator expands when free space is available
        }
        
        separator.style.flexShrink = 1.0 // Enable flexShrink so the separator shrinks when space is needed
        
        return separator
    }
    
    public func addShadow(color: UIColor, offSet: CGSize, radius: CGFloat, opacity: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOffset = offSet
        self.shadowRadius = radius
        self.shadowOpacity = opacity
    }
}

extension ASDisplayNode: SFDeviceProtocol {
    
    // MARK: - Instance Properties
    
    public var deviceType: SFDevice {
        get {
            if self.asyncTraitCollection().horizontalSizeClass == .regular && self.asyncTraitCollection().verticalSizeClass == .regular {
                return .ipad
            } else {
                if UIScreen.main.bounds.size.height >= 720 {
                    return .iphonePlus
                } else {
                    return .iphone
                }
            }
        }
    }
    
    public var isAnIphone: Bool {
        return self.deviceType == .iphone || self.deviceType == .iphonePlus ? true : false
    }
    
}
