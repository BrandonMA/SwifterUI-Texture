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
            self.prepareAnimation()
        }
    }
    open var animations: [SFAnimationType] = [] {
        didSet {
            self.prepareAnimation()
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
    open var initialAlpha: CGFloat = 1.0 { didSet { self.node?.alpha = self.initialAlpha } }
    open var finalAlpha: CGFloat = 1.0
    open var animationCurve: SFAnimationCurve = .linear
    open var animationCompletion: (Bool) -> Void = {_ in }
    open var currentAnimationIndex: Int = 0
    
    // MARK: - Initializers
    
    public init(with node: ASDisplayNode? = nil, animations: [SFAnimationType] = [.none]) {
        self.node = node
        self.animations = animations
        prepareAnimation()
    }
    
    // MARK: - Instance Methods
    
    // prepareAnimation: Methods inmediatly called after init, this prepare properties for all animations
    open func prepareAnimation() {
        self.animations.forEach { (animation) in
            load(animation: animation)
        }
    }
    
    // load(animation: SFAnimationType): Load default values for animations
    private func load(animation: SFAnimationType) {
        switch animation {
        case .zoomIn, .zoomOut:
            initialScaleX = animation == .zoomIn ? 1.5 : 1.0
            initialScaleY = animation == .zoomIn ? 1.5 : 1.0
            finalScaleX = animation == .zoomIn ? 1.0 : 1.5
            finalScaleY = animation == .zoomIn ? 1.0 : 1.5
        case .scaleIn, .scaleOut:
            initialScaleX = animation == .scaleIn ? 0.1 : 1.0
            initialScaleY = animation == .scaleIn ? 0.1 : 1.0
            finalScaleX = animation == .scaleIn ? 1.0 : 0.1
            finalScaleY = animation == .scaleIn ? 1.0 : 0.1
        case .fadeIn, .fadeOut:
            initialAlpha = animation == .fadeIn ? 0.0 : 1.0
            finalAlpha = animation == .fadeIn ? 1.0 : 0.0
        case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom, .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom:
            guard let node = self.node else { return }
            let maxWidth = node.supernode?.bounds.width ?? UIScreen.main.bounds.width
            let maxHeight = node.supernode?.bounds.height ?? UIScreen.main.bounds.height
            initialFrame = node.frame
            finalFrame = node.frame
            damping = 0.6
            
            if animation == .slideInRight {
                initialFrame.origin.x = maxWidth + initialFrame.size.width
            } else if animation == .slideInLeft {
                initialFrame.origin.x = 0 - initialFrame.size.width
            } else if animation == .slideInTop {
                initialFrame.origin.y = 0 - initialFrame.size.height
            } else if animation == .slideInBottom {
                initialFrame.origin.y = maxHeight + initialFrame.size.height
            } else if animation == .slideOutRight {
                finalFrame.origin.x = maxWidth + finalFrame.size.width
            } else if animation == .slideOutLeft {
                finalFrame.origin.x = 0 - finalFrame.size.width
            } else if animation == .slideOutTop {
                finalFrame.origin.y = 0 - finalFrame.size.height
            } else if animation == .slideOutBottom {
                finalFrame.origin.y = maxHeight + finalFrame.size.height
            }
            
            node.frame = initialFrame
        case .popDown, .popUp:
            self.animationCurve = .easeOut
            self.initialScaleX = animation == .popUp ? 1 + self.force * 0.2 : self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0
            self.finalScaleX = animation == .popUp ? self.force * 0.2 < 1 ? 1 - self.force * 0.2 : 0 : 1 + self.force * 0.2
        case .shake:
            guard let node = self.node else { return }
            self.initialFrame = node.frame
            self.animationCurve = .easeOut
        default: return
        }
    }
    
    // start: call start(animation: SFAnimationType) for all animations
    open func start() {
        Dispatch.addAsyncTask(to: .main) {
            if self.animations.count != 0 {
                self.animations.forEach({ (animation) in
                    self.start(animation: animation)
                })
            }
        }
    }
    
    private func start(animation: SFAnimationType) {
        switch animation {
        case .zoomIn, .zoomOut: self.zoomOrScale()
        case .scaleIn, .scaleOut: self.zoomOrScale()
        case .fadeIn, .fadeOut: self.fade()
        case .slideInRight, .slideInLeft, .slideInTop, .slideInBottom, .slideOutRight, .slideOutLeft, .slideOutTop, .slideOutBottom: self.slide()
        case .popDown, .popUp:
            self.load(animation: animation)
            self.pop()
        case .shake:
            self.load(animation: animation)
            self.shake()
        default: break
        }
    }
    
    public func didFinishAnimation() {
        self.currentAnimationIndex += 1
        if self.currentAnimationIndex == self.animations.count {
            self.didFinishAnimations()
        }
    }
    
    public func didFinishAnimations() {
        self.animationCompletion(true)
        self.restart()
    }
    
    public func restart() {
        delay = 0.0
        duration = 1
        damping = 1
        velocity = 0.0
        center = CGPoint.zero
        initialFrame = CGRect.zero
        finalFrame = CGRect.zero
        initialScaleX = 1
        initialScaleY = 1
        finalScaleX = 1
        finalScaleY = 1
        rotate = 0
        force = 1
        initialAlpha = 1
        finalAlpha = 1
        animationCurve = .linear
        animationCompletion = {_ in }
    }
}


































