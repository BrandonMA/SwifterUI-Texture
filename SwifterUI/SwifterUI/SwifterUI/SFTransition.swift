//
//  SFTransition.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Instance Properties
    
    open var animator: SFAnimator
    open var operation: UINavigationControllerOperation
    
    // MARK: - Initializers
    
    public init(animator: SFAnimator, operation: UINavigationControllerOperation) {
        self.animator = animator
        self.operation = operation
        super.init()
    }
    
    // MARK: - Instance Methods
    
    open func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animator.duration
    }
    
    open func animateTransition(using context: UIViewControllerContextTransitioning) {
        
        if operation == .pop { animator.inverted() }
        
        guard let animationVC = self.operation == .push ? context.viewController(forKey: .to) as? ASViewController : context.viewController(forKey: .from) as? ASViewController else { return }
        guard let toVC = context.viewController(forKey: .to) else { return }
        
        context.containerView.addSubview(toVC.view)
        
        animator.node = animationVC.node
        
        if self.operation == .pop {
            context.containerView.sendSubview(toBack: toVC.view)
        }
        
        let completionBlock: () -> Void = {
            context.completeTransition(true)
        }
        
        animator.animationCompletion = completionBlock
        animator.start()
    }
}
