//
//  SFAnimator.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAnimator {
    
    var view: UIView { didSet { self.loadAnimationPresets() } }
    open var animation: SFAnimationType  { didSet { self.loadAnimationPresets() } }
    open var force: CGFloat = 0
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 0
    open var damping: CGFloat = 1
    open var velocity: CGFloat = 0
    open var repeatCount: Float = 0
    open var center: CGPoint = CGPoint.zero
    open var initialFrame: CGRect = CGRect.zero
    open var scaleX: CGFloat = 1
    open var scaleY: CGFloat = 1
    open var rotate: CGFloat = 0
    open var initialAlpha: CGFloat = 1.0 { didSet { self.view.alpha = self.initialAlpha } }
    open var finalAlpha: CGFloat = 1
    open var animationOptions: UIViewAnimationOptions = []
    open var animationCompletion: (Bool) -> Void = {_ in }
    
    public init(with view: UIView, animation: SFAnimationType) {
        self.view = view
        self.animation = animation
    }
    
    convenience init(animation: SFAnimationType) {
        self.init(with: UIView(), animation: animation)
    }
    
    // loadAnimationPresets: Set the predefined values for each animation for convenience, in case that you don't define view at init, this will override any changes to all properties
    private func loadAnimationPresets() {
        switch self.animation {
        case .zoomIn:
            initialAlpha = 0.0
            finalAlpha = 1
            scaleX = 0
            scaleY = 0
            damping = 1
            duration = 0.6
        case .zoomOut:
            initialAlpha = 0.0
            finalAlpha = 1
            scaleX = 1.5
            scaleY = 1.5
            damping = 1
            duration = 0.6
        default: return
        }
    }
    
    open func startAnimation() {
        switch self.animation {
        case .zoomIn, .zoomOut:
            self.initialFrame = self.view.frame
            self.view.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
            self.view.center = CGPoint(x: initialFrame.size.width / 2, y: initialFrame.size.height / 2)
            UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: self.animationOptions, animations: {
                self.view.transform = .identity
                self.view.alpha = self.finalAlpha
                self.view.center = CGPoint(x: self.initialFrame.size.width / 2, y: self.initialFrame.size.height / 2)
            }, completion: { finished in
                self.animationCompletion(finished)
            })
        default: return
        }
    }
}

public enum SFAnimationType: String {
    case zoomIn
    case zoomOut
    case none
}
