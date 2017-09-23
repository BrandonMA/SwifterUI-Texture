//
//  SFDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFDisplayNode: ASDisplayNode, SFGradientProtocol, SFBlurredNode, SFDisplayNodeColorStyle {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool = false
    
    open var gradient: SFGradient? { didSet { self.setGradient() } }
    
    open var effect: UIVisualEffect?
    
    // isLoading: If you used addLoadingNode, set true or false to show a SFLoadingNode()
    open var isLoading = false
    
    open lazy var loadingNode: SFLoadingNode = {
        let node = SFLoadingNode()
        node.updateColors()
        node.alpha = 0.0
        return node
    }()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
        
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    // addLoadingNode: Adds a loadingNode to your custom layout
    // - Parameters:
    //   layout: your custom layout where it's added the loadingNode
    open func addLoadingNode(to layout: ASLayoutSpec) -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: layout, overlay: loadingNode)
    }
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
        if self.effect != nil { setEffect() }
    }

    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        for node in self.subnodes {
            if node == self.loadingNode {
                UIView.animate(withDuration: 0.3, animations: { self.loadingNode.alpha = self.isLoading == true ? 1.0 : 0.0 })
            } else {
                node.frame = context.initialFrame(for: node)
                UIView.animate(withDuration: 0.3, animations: {
                    node.frame = context.finalFrame(for: node)
                }, completion: { (finished) in
                    context.completeTransition(finished)
                })
            }
        }
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            self.loadingNode.updateColors()
            updateSubNodesColors()
        }
    }
}















