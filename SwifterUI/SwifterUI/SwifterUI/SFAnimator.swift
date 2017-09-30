//
//  SFAnimator.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAnimator {
    
    open var view: UIView {
        didSet {
            self.loadAnimationPresets()
        }
    }
    open var animation: SFAnimationType  {
        didSet {
            self.loadAnimationPresets()
        }
    }
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 0
    open var damping: CGFloat = 1
    open var velocity: CGFloat = 0
    open var repeatCount: Float = 0
    open var center: CGPoint = CGPoint.zero
    open var initialFrame: CGRect = CGRect.zero
    open var finalFrame: CGRect = CGRect.zero
    open var scaleX: CGFloat = 1
    open var scaleY: CGFloat = 1
    open var rotate: CGFloat = 0
    open var initialAlpha: CGFloat = 1.0 {
        didSet {
            self.view.alpha = self.initialAlpha
        }
    }
    open var finalAlpha: CGFloat = 1.0
    open var animationOptions: UIViewAnimationOptions = []
    open var animationCompletion: (Bool) -> Void = {_ in }
    open var reversed: Bool = false {
        didSet {
            switch self.animation {
            case .zoomIn: self.animation = .zoomOut
            case .zoomOut: self.animation = .zoomIn
            case .scaleIn: self.animation = .scaleOut
            case .scaleOut: self.animation = .scaleIn
            case .fadeIn: self.animation = .fadeOut
            case .fadeOut: self.animation = .fadeIn
            default: return
            }
        }
    }
    
    public init(with view: UIView, animation: SFAnimationType) {
        self.view = view
        self.animation = animation
        loadAnimationPresets()
    }
    
    public convenience init(wit view: UIView) {
        self.init(with: view, animation: SFAnimationType.none)
    }
    
    public convenience init(animation: SFAnimationType) {
        self.init(with: UIView(), animation: animation)
    }
    
    public convenience init() {
        self.init(with: UIView(), animation: SFAnimationType.none)
    }
    
    // loadAnimationPresets: Set the predefined values for each animation for convenience, in case that you don't define view at init, this will override any changes to all properties
    open func loadAnimationPresets() {
        switch self.animation {
        case .zoomIn, .zoomOut:
            initialAlpha = self.animation == .zoomIn ? 0.0 : 1.0
            finalAlpha = self.animation == .zoomIn ? 1.0 : 0.0
            scaleX = 1.5
            scaleY = 1.5
            damping = 1
            duration = 0.6
        case .scaleIn, .scaleOut:
            initialAlpha = self.animation == .scaleIn ? 0.0 : 1.0
            finalAlpha = self.animation == .scaleIn ? 1.0 : 0.0
            scaleX = 0.1
            scaleY = 0.1
            damping = 1
            duration = 0.6
        case .fadeIn, .fadeOut:
            initialAlpha = self.animation == .fadeIn ? 0.0 : 1.0
            finalAlpha = self.animation == .fadeIn ? 1.0 : 0.0
            duration = 0.6
        default: return
        }
    }
    
    open func startAnimation() {
        switch self.animation {
        case .zoomIn, .zoomOut: zoomOrScale()
        case .scaleIn, .scaleOut: zoomOrScale()
        case .fadeIn, .fadeOut: fade()
        default: return
        }
    }
}

// MARK: - Animations
extension SFAnimator {
    
    open func zoomOrScale() {
        self.initialFrame = self.view.frame
        self.view.center = CGPoint(x: initialFrame.size.width / 2, y: initialFrame.size.height / 2)
        
        if self.animation == .zoomIn || self.animation == .scaleIn {
            self.view.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
        }
        
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: self.animationOptions, animations: {
            
            self.view.alpha = self.finalAlpha
            self.view.center = CGPoint(x: self.initialFrame.size.width / 2, y: self.initialFrame.size.height / 2)
            
            if self.animation == .zoomIn || self.animation == .scaleIn {
                self.view.transform = .identity
            } else if self.animation == .zoomOut || self.animation == .scaleOut {
                self.view.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
            }
            
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
    open func fade() {
        UIView.animate(withDuration: self.duration, animations: {
            self.view.alpha = self.finalAlpha
        }) { (finished) in
            self.animationCompletion(finished)
        }
    }
}




































