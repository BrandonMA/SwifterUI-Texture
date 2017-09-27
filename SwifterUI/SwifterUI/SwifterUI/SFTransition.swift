//
//  SFTransition.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class SFTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animator: SFAnimator
    
    init(animator: SFAnimator) {
        self.animator = animator
        super.init()
    }
    
    func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animator.duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        
    }
}
