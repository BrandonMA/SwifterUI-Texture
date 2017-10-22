//
//  SFFadeInAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFFadeAnimation: SFAnimation {
    
    // MARK: - Instance Methods
    
    open override func load() {
        initialAlpha = self.type == .inside ? 0.0 : 1.0
        finalAlpha = self.type == .inside ? 1.0 : 0.0
        duration = 0.6
    }
    
    open override func start() {
        guard let node = self.node else { return }
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [self.animationCurve.getAnimationOptions(), .allowUserInteraction], animations: {
            node.alpha = self.finalAlpha
        }, completion: { finished in
            self.delegate?.didFinishAnimation()
        })
    }
}
