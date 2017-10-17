//
//  SFAnimator.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAnimator {
    
    // MARK: - Instance Properties
    
    open weak var node: ASDisplayNode? = nil {
        didSet {
            self.loadAnimationPresets()
        }
    }
    open var animation: SFAnimationType = .none {
        didSet {
            self.animationCompletion = {_ in }
            self.loadAnimationPresets()
        }
    }
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 1
    open var damping: CGFloat = 1
    open var velocity: CGFloat = 0
    open var center: CGPoint = CGPoint.zero
    open var initialFrame: CGRect = CGRect.zero
    open var finalFrame: CGRect = CGRect.zero
    open var initialScaleX: CGFloat = 1
    open var initialScaleY: CGFloat = 1
    open var finalScaleX: CGFloat = 1
    open var finalScaleY: CGFloat = 1
    open var rotate: CGFloat = 0
    open var force: CGFloat = 1
    open var initialAlpha: CGFloat = 1.0 {
        didSet {
            self.node?.alpha = self.initialAlpha
        }
    }
    open var finalAlpha: CGFloat = 1.0
    open var animationCurve: SFAnimationCurve = .linear
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
            case .slideInTop: self.animation = .slideOutTop
            case .slideInRight: self.animation = .slideOutRight
            case .slideInBottom: self.animation = .slideOutBottom
            case .slideInLeft: self.animation = .slideOutLeft
            // TODO: Implement the rest
            default: return
            }
        }
    }
    
    // MARK: - Initializers
    
    public init(with node: ASDisplayNode? = nil, animation: SFAnimationType = .none) {
        self.node = node
        self.animation = animation
        loadAnimationPresets()
    }
    
    // MARK: - Instance Methods
    
    // loadAnimationPresets: Set the predefined values for each animation for convenience, in case that you don't define view at init, this will override any changes to all properties
    open func loadAnimationPresets() {
        switch self.animation {
        case .zoomIn, .zoomOut:
            initialAlpha = self.animation == .zoomIn ? 0.0 : 1.0
            finalAlpha = self.animation == .zoomIn ? 1.0 : 0.0
            initialScaleX = 1.5
            initialScaleY = 1.5
            duration = 0.6
        case .scaleIn, .scaleOut:
            initialAlpha = self.animation == .scaleIn ? 0.0 : 1.0
            finalAlpha = self.animation == .scaleIn ? 1.0 : 0.0
            initialScaleX = 0.1
            initialScaleY = 0.1
            duration = 0.6
        case .fadeIn, .fadeOut:
            initialAlpha = self.animation == .fadeIn ? 0.0 : 1.0
            finalAlpha = self.animation == .fadeIn ? 1.0 : 0.0
            duration = 0.6
    case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom, .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom, .fadeInRight, .fadeInLeft, .fadeInTop, .fadeInBottom, .fadeOutRight, .fadeOutLeft, .fadeOutTop, .fadeOutBottom:
            guard let node = self.node else { return }
            
            let maxWidth = node.supernode?.bounds.width ?? UIScreen.main.bounds.width
            let maxHeight = node.supernode?.bounds.height ?? UIScreen.main.bounds.height
            
            if self.animation == .fadeInRight || self.animation == .fadeInLeft || self.animation == .fadeInTop || self.animation == .fadeInBottom  {
                self.initialAlpha = 0.0
            }
            
            if self.animation == .fadeOutRight || self.animation == .fadeOutLeft || self.animation == .fadeOutTop || self.animation == .fadeOutBottom  {
                self.finalAlpha = 0.0
            }
            
            initialFrame = node.frame
            finalFrame = node.frame
            damping = 0.6
            
            if self.animation == .slideInRight || self.animation == .fadeInRight {
                initialFrame.origin.x = maxWidth + initialFrame.size.width
            } else if self.animation == .slideInLeft || self.animation == .fadeInLeft {
                initialFrame.origin.x = 0 - initialFrame.size.width
            } else if self.animation == .slideInTop || self.animation == .fadeInTop {
                initialFrame.origin.y = 0 - initialFrame.size.height
            } else if self.animation == .slideInBottom || self.animation == .fadeInBottom {
                initialFrame.origin.y = maxHeight + initialFrame.size.height
            } else if self.animation == .slideOutRight || self.animation == .fadeOutRight {
                finalFrame.origin.x = maxWidth + finalFrame.size.width
            } else if self.animation == .slideOutLeft || self.animation == .fadeOutLeft {
                finalFrame.origin.x = 0 - finalFrame.size.width
            } else if self.animation == .slideOutTop || self.animation == .fadeOutTop {
                finalFrame.origin.y = 0 - finalFrame.size.height
            } else if self.animation == .slideOutBottom || self.animation == .fadeOutBottom {
                finalFrame.origin.y = maxHeight + finalFrame.size.height
            }
            
            node.frame = initialFrame
        case .popDown, .popUp, .fadePopUp, .fadePopDown:
            self.duration = 1.0
            self.animationCurve = .easeOut
            
            if self.animation == .fadePopDown || self.animation == .fadePopUp {
                self.initialAlpha = 0.0
            }
            
            if self.animation == .popUp || self.animation == .fadePopDown {
                self.initialScaleX = 1 + self.force * 0.2
                self.finalScaleX = self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0
            } else {
                self.initialScaleX = self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0
                self.finalScaleX = 1 + self.force * 0.2
            }
        case .shake:
            guard let node = self.node else { return }
            self.initialFrame = node.frame
            self.animationCurve = .easeOut
            self.duration = 0.6
        default: return
        }
    }
    
    open func startAnimation() {
        
        Dispatch.addAsyncTask(to: DispatchLevel.main) {
            switch self.animation {
            case .zoomIn, .zoomOut: self.zoomOrScale()
            case .scaleIn, .scaleOut: self.zoomOrScale()
            case .fadeIn, .fadeOut: self.fade()
        case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom, .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom, .fadeInRight, .fadeInLeft, .fadeInTop, .fadeInBottom, .fadeOutRight, .fadeOutLeft, .fadeOutTop, .fadeOutBottom: self.slide()
            case .popDown, .popUp, .fadePopDown, .fadePopUp:
                self.loadAnimationPresets()
                self.pop()
            case .shake:
                self.loadAnimationPresets()
                self.shake()
            default: return
            }
        }
    }
}


































