//
//  SFDeviceProtocol.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFDeviceProtocol {
    // deviceType: Identifier to know if you are working on an ipad, iphone or iphone plus
    var deviceType: SFDevice { get }
}

extension SFDeviceProtocol where Self: ASDisplayNode {
    
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
    
}
