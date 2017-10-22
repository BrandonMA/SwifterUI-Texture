//
//  SFPopAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPopAnimation: SFAnimation {
    
    // MARK: - Instance Methods
    
    open override func load() {
        self.animationCurve = .easeOut
        self.initialScaleX = type == .outside ? 1 + self.force * 0.2 : self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0
        self.finalScaleX = type == .outside ? self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0 : 1 + self.force * 0.2
    }
    
    open override func start() {
        guard let node = self.node else { return }
        CATransaction.begin()
        CATransaction.setCompletionBlock({ self.delegate?.didFinishAnimation() })
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, self.initialScaleX, self.finalScaleX, self.initialScaleX, 1]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = animationCurve.getTimingFunction()
        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        node.view.layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}
