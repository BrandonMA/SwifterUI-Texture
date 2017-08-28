//
//  SFDisplayNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFDisplayNode: ASDisplayNode, SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool = false
    
    // isLoading: If you used addLoadingNode, set true or false to show a FluidLoadingNode()
    open var isLoading = false

    // deviceType: Identifier to know if you are working on an ipad, iphone or iphone plus
    public var deviceType: SFDevice {
        get {
            
            if self.asyncTraitCollection().horizontalSizeClass == .regular && self.asyncTraitCollection().verticalSizeClass == .regular {
                return .ipad
            } else {
                if UIScreen.main.bounds.size.height >= 720 {
                    return .iphonePlus
                } else {
                    return .iphone
                }
            }
        }
    }
    
    // isAnIphone: return true if it is an iphone or iphone plus
    public var isAnIphone: Bool {
        get {
            return self.deviceType == .iphone || self.deviceType == .iphonePlus ? true : false
        }
    }
    
    // gradient: Gradient to be used as background
    open var gradient: SFGradient? { didSet {setGradient()} }
    
    private var gradientLayer: CAGradientLayer? = nil
    
    lazy var loadingNode: SFLoadingNode = {
        let node = SFLoadingNode()
        node.updateColors()
        node.alpha = 0.0
        return node
    }()
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update colors
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    public override convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
        
    // MARK: - Instance Methods
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.backgroundColor = self.colorStyle.getBackgroundColor()
            self.loadingNode.updateColors()
            updateSubNodesColors()
        }
    }
    
    // addLoadingNode: Adds a loadingNode to your custom layout
    // - Parameters:
    //   layout: your custom layout where it's added the loadingNode
    public func addLoadingNode(to layout: ASLayoutSpec) -> ASLayoutSpec {
        loadingNode.style.preferredSize = self.frame.size
        return ASOverlayLayoutSpec(child: layout, overlay: loadingNode)
    }

    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        UIView.animate(withDuration: 0.3, animations: { self.loadingNode.alpha = self.isLoading == true ? 1.0 : 0.0 })
    }
    
    private func setGradient() {
        if self.frame.width != 0 && self.frame.height != 0 {
            guard let layer = gradient?.getGradientLayer(width: self.frame.width, height: self.frame.height) else { return }
            
            if let gradientLayer = gradientLayer {
                self.layer.replaceSublayer(gradientLayer, with: layer)
            } else {
                self.layer.insertSublayer(layer, at: 0)
            }
            
            self.gradientLayer = layer
        }
    }
}


















