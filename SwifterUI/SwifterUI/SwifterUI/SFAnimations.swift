//
//  SFAnimations.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 16/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

// MARK: - Animations

extension SFAnimator {
    
    open func zoomOrScale() {
        guard let node = self.node else { return }
        self.initialFrame = node.frame
        node.view.center = CGPoint(x: initialFrame.size.width / 2, y: initialFrame.size.height / 2)
        if self.animation == .zoomIn || self.animation == .scaleIn {
            node.view.transform = CGAffineTransform(scaleX: self.initialScaleX, y: self.initialScaleY)
        }
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [self.animationCurve.getAnimationOptions(), .allowUserInteraction], animations: {
            node.alpha = self.finalAlpha
            node.view.center = CGPoint(x: self.initialFrame.size.width / 2, y: self.initialFrame.size.height / 2)
            if self.animation == .zoomIn || self.animation == .scaleIn {
                node.view.transform = .identity
            } else if self.animation == .zoomOut || self.animation == .scaleOut {
                node.view.transform = CGAffineTransform(scaleX: self.initialScaleX, y: self.initialScaleY)
            }
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
    open func fade() {
        UIView.animate(withDuration: self.duration, animations: {
            self.node?.alpha = self.finalAlpha
        }) { (finished) in
            self.animationCompletion(finished)
        }
    }
    
    open func slide() {
        guard let node = self.node else { return }
        node.frame = initialFrame
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [self.animationCurve.getAnimationOptions(), .allowUserInteraction], animations: {
            node.alpha = self.finalAlpha
            node.frame = self.finalFrame
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
    open func pop() {
        guard let node = self.node else { return }
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, self.initialScaleX, self.finalScaleX, self.initialScaleX, 1]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = animationCurve.getTimingFunction()
        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        node.view.layer.add(animation, forKey: nil)
        
        UIView.animate(withDuration: self.duration) {
            node.alpha = self.finalAlpha
        }
    }
    
    open func shake() {
        guard let node = self.node else { return }
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        let modifier = 10 * self.force
        animation.values = [self.initialFrame.midX, self.initialFrame.midX + modifier, self.initialFrame.midX, self.initialFrame.midX - modifier, self.initialFrame.midX + modifier, self.initialFrame.midX]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = self.animationCurve.getTimingFunction()
        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        node.view.layer.add(animation, forKey: nil)
    }
    
}












