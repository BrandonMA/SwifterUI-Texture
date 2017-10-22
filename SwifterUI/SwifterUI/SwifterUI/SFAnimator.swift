//
//  SFAnimator.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFAnimator: SFAnimationDelegate {
    
    // MARK: - Instance Properties
    
    open weak var node: ASDisplayNode? = nil {
        didSet {
            self.prepareAnimations()
        }
    }
    
    open var animations: [SFAnimation] = [] {
        didSet {
            self.prepareAnimations()
        }
    }
    
    open var duration: TimeInterval {
        get {
            var max: TimeInterval = 0
            self.animations.forEach { (animation) in
                max = animation.duration > max ? animation.duration : max
            }
            return max
        } set(newValue) {
            self.animations.forEach { (animation) in
                animation.duration = newValue
            }
        }
    }
    
    open var delay: Double = 0
    open var animationCompletion: () -> Void = {}
    open var currentAnimationIndex: Int = 0
    
    // MARK: - Initializers
    
    public init(with node: ASDisplayNode? = nil, animations: [SFAnimation] = []) {
        self.node = node
        self.animations = animations
        prepareAnimations()
    }
    
    // MARK: - Instance Methods
    
    // prepareAnimation: Methods inmediatly called after init, this prepare properties for all animations
    open func prepareAnimations() {
        self.animations.forEach { (animation) in
            animation.delegate = self
            animation.node = self.node
        }
    }
    
    // start: call start(animation: SFAnimationType) for all animations
    open func start() {
        Dispatch.delay(by: delay, dispatchLevel: .main) {
            if self.animations.count != 0 {
                self.animations.forEach({ (animation) in
                    animation.start()
                })
            }
        }
    }
    
    open func didFinishAnimation() {
        self.currentAnimationIndex += 1
        if self.currentAnimationIndex == self.animations.count {
            self.didFinishAnimations()
        }
    }
    
    open func didFinishAnimations() {
        self.animationCompletion()
        self.restart()
    }
    
    open func restart() {
        delay = 0
        currentAnimationIndex = 0
        animationCompletion = {}
    }
    
    open func inverted() {
        self.animations.forEach { (animation) in
            animation.inverted()
        }
    }
    
}
































