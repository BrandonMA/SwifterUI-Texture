//
//  SFDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFDisplayNode: ASDisplayNode, SFGradientNode, SFBlurredNode, SFDisplayNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
    
    // isLoading: If you used addLoadingNode, set true or false to show a SFLoadingNode()
    open var isLoading = false
    
    open lazy var loadingNode: SFLoadingNode = {
        let node = SFLoadingNode()
        node.updateColors()
        node.alpha = 0.0
        return node
    }()
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool = false
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFGradientNode
    
    open var gradient: SFGradient? { didSet { self.setGradient() } }
    
    // MARK: - SFBlurredNode
    
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
    
    // addLoadingNode: Adds a loadingNode to your custom layout
    // - Parameters:
    //   layout: your custom layout where it's added the loadingNode
    open func addLoadingNode(to layout: ASLayoutSpec) -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: layout, overlay: loadingNode)
    }
    
    open func startLoading() {
        handle(loading: true)
    }
    
    open func stopLoading() {
        handle(loading: false)
    }
    
    private func handle(loading: Bool) {
        self.isLoading = loading
        Dispatch.addAsyncTask(to: DispatchLevel.main) {
            self.transitionLayout(withAnimation: true, shouldMeasureAsync: false, measurementCompletion: nil)
        }
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
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            if self.effect != nil {
                self.backgroundColor = UIColor.clear
            } else {
                self.backgroundColor = self.shouldHaveAlternativeColors == false ? self.colorStyle.getBackgroundColor() : self.colorStyle.getAlternativeBackgroundColor()
            }
            self.loadingNode.updateColors()
            updateSubNodesColors()
        }
    }
}















