//
//  SFBlurredProtocol.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 02/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFBlurredNode {
    
    // MARK: - Instance Properties
    
    // effect: UIVisualEffect that is going to be used as background
    var effect: UIVisualEffect? { get set }
    
    // MARK: - Instance Methods
    
    func setEffect()
}

public extension SFBlurredNode where Self: ASDisplayNode {
    
    // MARK: - Instance Methods
    
    // Please add if self.setEffect != nil { setEffect() } to layout() function so this is called, if you don't do this the effect is going to have an incorrect size
    public func setEffect() {
        if self.frame.width != 0 && self.frame.height != 0 {
            if let effect = self.effect {
                let effectView = UIVisualEffectView(effect: effect)
                effectView.frame = self.bounds
                effectView.isUserInteractionEnabled = false
                
                for subview in self.view.subviews {
                    if subview.isKind(of: UIVisualEffectView.self) {
                        subview.removeFromSuperview()
                    }
                }
                self.view.insertSubview(effectView, at: 0)
            }
        }
    }
    
}
