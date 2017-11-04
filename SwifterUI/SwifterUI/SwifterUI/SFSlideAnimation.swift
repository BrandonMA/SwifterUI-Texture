//
//  SFSlideAnimation.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFSlideAnimation: SFAnimation {

    // MARK: - Instance Methods
    
    open override func load() {
        guard let node = self.node else { return }
        let maxWidth = node.supernode?.bounds.width ?? UIScreen.main.bounds.width
        let maxHeight = node.supernode?.bounds.height ?? UIScreen.main.bounds.height
        
        initialFrame = node.frame
        finalFrame = node.frame
        damping = 0.5
        
        if direction == .right && type == .inside {
            initialFrame.origin.x = maxWidth + initialFrame.size.width
        } else if direction == .left && type == .inside {
            initialFrame.origin.x = 0 - initialFrame.size.width
        } else if direction == .top && type == .inside {
            initialFrame.origin.y = 0 - initialFrame.size.height
        } else if direction == .bottom && type == .inside {
            initialFrame.origin.y = maxHeight + initialFrame.size.height
        } else if direction == .right && type == .outside {
            finalFrame.origin.x = maxWidth + finalFrame.size.width
        } else if direction == .left && type == .outside {
            finalFrame.origin.x = 0 - finalFrame.size.width
        } else if direction == .top && type == .outside {
            finalFrame.origin.y = 0 - finalFrame.size.height
        } else if direction == .bottom && type == .outside {
            finalFrame.origin.y = maxHeight + finalFrame.size.height
        }
        
        node.frame = initialFrame

    }
    
    open override func start() {
        guard let node = self.node else { return }
        node.frame = initialFrame
        UIView.animate(withDuration: self.duration, delay: self.delay, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [self.animationCurve.getAnimationOptions(), .allowUserInteraction], animations: {
            node.frame = self.finalFrame
        }, completion: { finished in
            self.delegate?.didFinishAnimation()
        })
    }
}


