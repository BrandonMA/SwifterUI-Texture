//
//  SFAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFAnimationDelegate: class {
    func didFinishAnimation()
}

open class SFAnimation {
    
    public enum SFAnimationDirection {
        case top
        case bottom
        case left
        case right
        case none
    }
    
    public enum SFAnimationType {
        case inside
        case outside
        case none
    }
    
    // MARK: - Instance Properties
    
    open weak var node: ASDisplayNode? = nil { didSet { self.load() } }
    open weak var delegate: SFAnimationDelegate? = nil
    open var direction: SFAnimationDirection { didSet { self.load() } }
    open var type: SFAnimationType { didSet { self.load() } }
    open var delay: TimeInterval = 0
    open var duration: TimeInterval = 1
    open var damping: CGFloat = 1
    open var velocity: CGFloat = 0
    open var force: CGFloat = 1
    open var center: CGPoint = CGPoint.zero
    open var initialFrame: CGRect = CGRect.zero
    open var finalFrame: CGRect = CGRect.zero
    open var initialScaleX: CGFloat = 1
    open var initialScaleY: CGFloat = 1
    open var finalScaleX: CGFloat = 1
    open var finalScaleY: CGFloat = 1
    open var initialAlpha: CGFloat = 1.0 { didSet { self.node?.alpha = self.initialAlpha } }
    open var finalAlpha: CGFloat = 1.0
    open var animationCurve: SFAnimationCurve = .linear
    
    // MARK: - Initializers
    
    public init(with node: ASDisplayNode? = nil, direction: SFAnimationDirection = .none, type: SFAnimationType = .none) {
        self.type = type
        self.node = node
        self.direction = direction
        self.load()
    }
    
    // MARK: - Instance Methods
    
    // load: Methods inmediatly called after init, this prepare properties for all animations
    open func load() {
        
    }
    
    // start: All animations should be implemented here
    open func start() {
        
    }
    
    open func inverted() {
        self.type = self.type == .inside ? .outside : .inside
    }
}





