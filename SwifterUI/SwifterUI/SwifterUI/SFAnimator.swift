//
//  SFAnimator.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAnimator {
    
    open weak var view: UIView? = nil {
        didSet {
            self.loadAnimationPresets()
        }
    }
    open var animation: SFAnimationType = .none {
        didSet {
            self.loadAnimationPresets()
        }
    }
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 1
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
            self.view?.alpha = self.initialAlpha
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
    
    public init(with view: UIView? = nil, animation: SFAnimationType = .none) {
        self.view = view
        self.animation = animation
        loadAnimationPresets()
    }
    
    // loadAnimationPresets: Set the predefined values for each animation for convenience, in case that you don't define view at init, this will override any changes to all properties
    open func loadAnimationPresets() {
        switch self.animation {
        case .zoomIn, .zoomOut:
            initialAlpha = self.animation == .zoomIn ? 0.0 : 1.0
            finalAlpha = self.animation == .zoomIn ? 1.0 : 0.0
            scaleX = 1.5
            scaleY = 1.5
            duration = 0.6
        case .scaleIn, .scaleOut:
            initialAlpha = self.animation == .scaleIn ? 0.0 : 1.0
            finalAlpha = self.animation == .scaleIn ? 1.0 : 0.0
            scaleX = 0.1
            scaleY = 0.1
            duration = 0.6
        case .fadeIn, .fadeOut:
            initialAlpha = self.animation == .fadeIn ? 0.0 : 1.0
            finalAlpha = self.animation == .fadeIn ? 1.0 : 0.0
            duration = 0.6
        case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom:
            guard let view = self.view else { return }
            guard let superview = view.superview else { return }
            initialFrame = view.frame
            finalFrame = view.frame
            if self.animation == .slideInRight || self.animation == .slideInLeft {
                initialFrame.origin.x = self.animation == .slideInRight ? superview.frame.width + initialFrame.size.width : 0 - initialFrame.size.width
            } else  if self.animation == .slideInTop || self.animation == .slideInBottom {
                initialFrame.origin.y = self.animation == .slideInTop ? 0 - initialFrame.size.height : superview.frame.height + initialFrame.size.height
            }
        case .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom:
            guard let view = self.view else { return }
            guard let superview = view.superview else { return }
            self.initialFrame = view.frame
            self.finalFrame = view.frame
            if self.animation == .slideOutRight || self.animation == .slideOutLeft {
                finalFrame.origin.x = self.animation == .slideOutRight ? superview.frame.width + finalFrame.size.width : 0 - finalFrame.size.width
                print(finalFrame.origin.x)
            } else if self.animation == .slideOutTop || self.animation == .slideOutBottom {
                finalFrame.origin.y = self.animation == .slideOutTop ? 0 - finalFrame.size.height : superview.frame.height + finalFrame.size.height
            }
            
        default: return
        }
    }
    
    open func startAnimation() {
        Dispatch.addAsyncTask(to: DispatchLevel.main) {
            switch self.animation {
            case .zoomIn, .zoomOut: self.zoomOrScale()
            case .scaleIn, .scaleOut: self.zoomOrScale()
            case .fadeIn, .fadeOut: self.fade()
            case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom: self.slideIn()
            case .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom: self.slideOut()
            default: return
            }
        }
    }
}

// MARK: - Animations
extension SFAnimator {
    
    open func zoomOrScale() {
        guard let view = self.view else { return }
        self.initialFrame = view.frame
        view.center = CGPoint(x: initialFrame.size.width / 2, y: initialFrame.size.height / 2)
        
        if self.animation == .zoomIn || self.animation == .scaleIn {
            view.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
        }
        
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: self.animationOptions, animations: {
            view.alpha = self.finalAlpha
            view.center = CGPoint(x: self.initialFrame.size.width / 2, y: self.initialFrame.size.height / 2)
            
            if self.animation == .zoomIn || self.animation == .scaleIn {
                view.transform = .identity
            } else if self.animation == .zoomOut || self.animation == .scaleOut {
                view.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
            }
            
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
    open func fade() {
        UIView.animate(withDuration: self.duration, animations: {
            self.view?.alpha = self.finalAlpha
        }) { (finished) in
            self.animationCompletion(finished)
        }
    }
    
    open func slideIn() {
        guard let view = self.view else { return }
        view.frame = initialFrame
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: self.animationOptions, animations: {
            view.alpha = self.finalAlpha
            view.frame = self.finalFrame
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
    open func slideOut() {
        guard let view = self.view else { return }
        view.frame = initialFrame
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: self.animationOptions, animations: {
            view.alpha = self.finalAlpha
            view.frame = self.finalFrame
        }, completion: { finished in
            self.animationCompletion(finished)
        })
    }
    
}




































