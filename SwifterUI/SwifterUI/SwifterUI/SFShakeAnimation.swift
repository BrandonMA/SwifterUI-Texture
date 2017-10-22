//
//  SFShakeAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFShakeAnimation: SFAnimation {
    
    // MARK: - Instance Methods
    
    open override func load() {
        guard let node = self.node else { return }
        self.initialFrame = node.frame
        self.animationCurve = .easeOut
    }
    
    open override func start() {
        guard let node = self.node else { return }
        CATransaction.begin()
        CATransaction.setCompletionBlock({ self.delegate?.didFinishAnimation() })
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        let modifier = 10 * self.force
        animation.values = [self.initialFrame.midX, self.initialFrame.midX + modifier, self.initialFrame.midX, self.initialFrame.midX - modifier, self.initialFrame.midX + modifier, self.initialFrame.midX]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = self.animationCurve.getTimingFunction()
        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        node.view.layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}

