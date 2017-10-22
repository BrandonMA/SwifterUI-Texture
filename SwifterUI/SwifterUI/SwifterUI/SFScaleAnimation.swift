//
//  SFScaleInAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFScaleAnimation: SFZoomAnimation {
    
    // MARK: - Instance Methods
    
    open override func load() {
        initialScaleX = self.type == .inside ? 0.01 : 1.0
        initialScaleY = self.type == .inside ? 0.01 : 1.0
        finalScaleX = self.type == .inside ? 1.0 : 0.01
        finalScaleY = self.type == .inside ? 1.0 : 0.01
        initialAlpha = self.type == .inside ? 0.0 : 1.0
        finalAlpha = self.type == .inside ? 1.0 : 0.0
        self.duration = 0.6
    }
}
