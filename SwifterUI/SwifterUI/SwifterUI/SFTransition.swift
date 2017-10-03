//
//  SFTransition.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    open var animator: SFAnimator
    open var operation: UINavigationControllerOperation
    
    public init(animator: SFAnimator, operation: UINavigationControllerOperation) {
        self.animator = animator
        self.operation = operation
        super.init()
    }
    
    open func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animator.duration
    }
    
    open func animateTransition(using context: UIViewControllerContextTransitioning) {
        
        if operation == .pop { animator.reversed = true }
        
        guard let animationVC = self.operation == .push ? context.viewController(forKey: UITransitionContextViewControllerKey.to) as? ASViewController : context.viewController(forKey: UITransitionContextViewControllerKey.from) as? ASViewController else { return }
        guard let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        context.containerView.addSubview(toVC.view)
        
        animator.node = animationVC.node
        
        if self.operation == .pop {
            context.containerView.sendSubview(toBack: toVC.view)
        }
        
        let completionBlock: (Bool) -> Void = { finished in
            context.completeTransition(finished)
        }
        
        animator.animationCompletion = completionBlock
        animator.startAnimation()
    }
}
