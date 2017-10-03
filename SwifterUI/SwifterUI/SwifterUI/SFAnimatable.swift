//
//  SFAnimatable.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFAnimatable {
    var animator: SFAnimator { get set }
}

public extension SFAnimatable where Self: ASDisplayNode {
    public func isAnimationReady() {
        if self.isLayerBacked == false {
            self.animator.node = self
        }
    }
}
