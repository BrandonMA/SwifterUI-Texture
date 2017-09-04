//
//  SFGradientProtocol.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 02/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFGradientProtocol {
    
    // gradient: Gradient to be used as background
    var gradient: SFGradient? { get set }
    
    func setGradient()
    
}

extension SFGradientProtocol where Self: ASDisplayNode {
    
    // Please add if self.gradient != nil { setGradient() } to layout() function so this is called, if you don't do this the gradient is going to have an incorrect size
    public func setGradient() {
        if self.frame.width != 0 && self.frame.height != 0 {
            guard let gradientLayer = gradient?.getGradientLayer(width: self.frame.width, height: self.frame.height) else { return }
            if let layer = self.layer.sublayers?[0] {
                if layer.isKind(of: CAGradientLayer.self) {
                    self.layer.replaceSublayer(layer, with: gradientLayer)
                } else {
                    self.layer.insertSublayer(gradientLayer, at: 0)
                }
            } else {
                self.layer.insertSublayer(gradientLayer, at: 0)
            }
        }
    }
    
}
