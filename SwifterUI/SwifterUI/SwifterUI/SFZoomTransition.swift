//
//  SFZoomInTransition.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class SFZoomTransition: SFTransition {
    override func animateTransition(using context: UIViewControllerContextTransitioning) {
        guard let toVC = context.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        context.containerView.addSubview(toVC.view)
        animator.view = toVC.view
        
        let completionBlock: (Bool) -> Void = { finished in
            context.completeTransition(finished)
        }
        
        animator.animationCompletion = completionBlock
        animator.startAnimation()
    }
}

class SFZoomInTransition: SFZoomTransition {
    init() {
        super.init(animator: SFAnimator(animation: SFAnimationType.zoomIn))
    }
}

class SFZoomOutTransition: SFZoomTransition {
    init() {
        super.init(animator: SFAnimator(animation: SFAnimationType.zoomOut))
    }
}
