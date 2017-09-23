//
//  SFViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFViewController<SFNodeType: SFColorStyleProtocol>: ASViewController<ASDisplayNode> where SFNodeType: ASDisplayNode {
    
    // MARK: - Instance Properties
    
    open var currentColorStyle: SFColorStyle? = nil
    
    // SFNode: Node that you are going to be using to build your UI
    open var SFNode: SFNodeType
    
    open var automaticallyAdjustsColorStyle: Bool = false {
        didSet {
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    // preferredStatusBarStyle: Override the preferred status bar style with an colorStyle's getStatusBarStyle method that automatically return the correct statusbarstyle
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // automaticallyAdjustsLayoutInsets: This property enables automatic addition of Insets on reloadLayout()
    open var automaticallyAdjustsLayoutInsets: Bool = false
        
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(SFNode: SFNodeType, automaticallyAdjustsColorStyle: Bool) {
        
        self.SFNode = SFNode
        
        super.init(node: ASDisplayNode())
                
        node.automaticallyManagesSubnodes = true
        
        node.addSubnode(self.SFNode)
        
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        
        self.node.layoutSpecBlock = { constrainedSize in
            
            self.SFNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.0.bounds.width), height: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.0.bounds.height))
            
            return ASCenterLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: self.SFNode)
        }
        
        handleColorStyleCheck()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    // handleBrightnessChange: Because of the way protocols work, you need to declare an extra @objc function to call updateColors() because it is not an @objc and a notificion can't keep track of it
    @objc final func handleBrightnessChange() {
        updateColors()
    }
    
    open func updateColors() {
        if currentColorStyle != self.colorStyle || self.currentColorStyle == nil {
            if self.automaticallyAdjustsColorStyle == true {
                forceUpdateColors()
            }
        }
    }
    
    open func forceUpdateColors() {
        Dispatch.addAsyncTask(to: DispatchLevel.main) {
            UIView.animate(withDuration: 0.3, animations: {
                
                self.statusBarStyle = self.colorStyle.getStatusBarStyle()
                
                // This is called first so your SFNode(a subnode of your main node) is updated first, then all it's subnodes.
                self.updateSubNodesColors()
                
                // Once your SFNode is updated your main node(the one that comes with ASViewController) changes it's color to the correct one. This is make at the end because the main node should never be visible.
                self.node.backgroundColor = self.SFNode.backgroundColor
                
                self.navigationController?.navigationBar.barStyle = self.colorStyle.getNavigationBarStyle()
                
                self.navigationController?.navigationBar.tintColor = self.colorStyle.getInteractiveColor()
                
                self.setNeedsStatusBarAppearanceUpdate()
                
                self.currentColorStyle = self.colorStyle
                
            })
        }
    }
    
    open func updateSubNodesColors() {
        self.SFNode.updateColors()
    }
}

extension SFViewController: SFColorController {
    
    open func handleColorStyleCheck() {
        if automaticallyAdjustsColorStyle == true {
            self.updateColors()
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    open func automaticallyAdjustsColorStyleHandler() {
        if self.automaticallyAdjustsColorStyle == true {
            NotificationCenter.default.addObserver(self, selector: #selector(handleBrightnessChange), name: .UIScreenBrightnessDidChange, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
}



























