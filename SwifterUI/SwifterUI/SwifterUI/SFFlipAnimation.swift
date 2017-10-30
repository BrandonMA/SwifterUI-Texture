//
//  SFFlipAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 24/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFFlipAnimation: SFAnimation {
    
    public enum SFFlipType {
        case x
        case y
    }
    
    // MARK: - Instance Properties
    
    open var flipType: SFFlipType
    
    // MARK: - Initializers
    
    public init(with node: SFDisplayNode? = nil, flipType: SFFlipType = .x) {
        self.flipType = flipType
        super.init(with: node, direction: .none, type: .none)
    }
    
    // MARK: - Instance Methods
    
    open override func start() {
        guard let node = self.node else { return }
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / node.view.layer.frame.size.width/2
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({ self.delegate?.didFinishAnimation() })
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DMakeRotation(0, 0, 0, 0))
        animation.toValue = NSValue(caTransform3D: CATransform3DConcat(perspective, CATransform3DMakeRotation(CGFloat(CGFloat.pi), self.flipType == .x ? 0 : 1, self.flipType == .x ? 1 : 0, 0)))
        animation.duration = CFTimeInterval(duration)
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        animation.timingFunction = self.animationCurve.getTimingFunction()
        node.view.layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
    
}
