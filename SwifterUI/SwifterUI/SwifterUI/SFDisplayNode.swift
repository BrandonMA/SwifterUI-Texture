//
//  SFDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFDisplayNode: ASDisplayNode, SFGradientNode, SFBlurredNode, SFNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
    
    // isLoading: If you used addLoadingNode, set true or false to show a SFLoadingNode()
    open var isLoading = false
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool = false
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFGradientNode
    
    open var gradient: SFGradient? { didSet { self.setGradient() } }
    
    // MARK: - SFBlurredNode
    
    open var shouldHaveBackgroundBlur: Bool = false
    
    open var effect: UIVisualEffect? { didSet { self.setEffect() } }
    
    // MARK: - SFAnimatable
    
    open lazy var animator: SFAnimator = SFAnimator(with: self)
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
    }

    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
        
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
        automaticallyManagesSubnodes = true
    }
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
        if self.effect != nil { setEffect() }
    }

    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        for node in self.subnodes {
            node.frame = context.initialFrame(for: node)
            UIView.animate(withDuration: 0.3, animations: {
                node.frame = context.finalFrame(for: node)
            }, completion: { (finished) in
                context.completeTransition(finished)
            })
        }
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            
            self.tintColor = self.colorStyle.getInteractiveColor()
            
            if self.shouldHaveBackgroundBlur == true {
                self.effect = self.colorStyle.getCorrectEffect()
            }
            
            if self.effect != nil {
                self.backgroundColor = UIColor.clear
            } else {
                self.backgroundColor = self.shouldHaveAlternativeColors == false ? self.colorStyle.getBackgroundColor() : self.colorStyle.getAlternativeBackgroundColor()
            }
            
            updateSubNodesColors()
        }
    }
}















