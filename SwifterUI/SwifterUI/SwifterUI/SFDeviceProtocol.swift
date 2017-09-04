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
    
    // isAnIphone: return true if it is an iphone or iphone plus
    var isAnIphone: Bool { get }
}
