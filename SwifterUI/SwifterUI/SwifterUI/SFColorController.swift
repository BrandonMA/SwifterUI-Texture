//
//  SFControllerProtocol.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFColorController: SFColorStyleProtocol {
        
    // statusBarStyle: This enables preferredStatusBarStyle changes on the go, without needing to
    var statusBarStyle: UIStatusBarStyle { get set }
        
    // handleColorStyleCheck: Update colors and start a listener
    func handleColorStyleCheck()
    
    // automaticallyAdjustsColorStyleHandler: Creates a new NotificationCenter observer that calls handleBrightnessChange whenever the brightness change
    func automaticallyAdjustsColorStyleHandler()
    
}
