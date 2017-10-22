//
//  SFZoomAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFZoomAnimation: SFAnimation {
    
    // MARK: - Instance Methods
    
    open override func load() {
        initialScaleX = self.type == .inside ? 1.5 : 1.0
        initialScaleY = self.type == .inside ? 1.5 : 1.0
        finalScaleX = self.type == .inside ? 1.0 : 1.5
        finalScaleY = self.type == .inside ? 1.0 : 1.5
        initialAlpha = self.type == .inside ? 0.0 : 1.0
        finalAlpha = self.type == .inside ? 1.0 : 0.0
        duration = 0.6
    }
    
    open override func start() {
        guard let node = self.node else { return }
        self.initialFrame = node.frame
        node.view.center = CGPoint(x: initialFrame.size.width / 2, y: initialFrame.size.height / 2)
        node.view.transform = CGAffineTransform(scaleX: self.initialScaleX, y: self.initialScaleY)
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [self.animationCurve.getAnimationOptions(), .allowUserInteraction], animations: {
            node.alpha = self.finalAlpha
            node.view.center = CGPoint(x: self.initialFrame.size.width / 2, y: self.initialFrame.size.height / 2)
            node.view.transform = CGAffineTransform(scaleX: self.finalScaleX, y: self.finalScaleY)
        }, completion: { finished in
            self.delegate?.didFinishAnimation()
        })
    }
}










