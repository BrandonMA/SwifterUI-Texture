//
//  SFViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFViewController<SFNodeType>: ASViewController<ASDisplayNode>, SFColorStyleProtocol where SFNodeType: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    var presentationManager: SFPresentationManager<SFNodeType>? = nil
    
    // SFNode: Node that you are going to be using to build your UI
    public var SFNode: SFNodeType
    
    // automaticallyAdjustsColorStyle: This property enables automatic change between light and dark mode
    open var automaticallyAdjustsColorStyle: Bool = false {
        didSet {
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    // preferredStatusBarStyle: Override the preferred status bar style with an colorStyle's getStatusBarStyle method that automatically return the correct statusbarstyle
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    // statusBarStyle: This enables preferredStatusBarStyle changes on the go, without needing to 
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
        
        self.statusBarStyle = colorStyle.getStatusBarStyle()
        
        self.SFNode.backgroundColor = colorStyle.getBackgroundColor()
        
        node.backgroundColor = self.SFNode.backgroundColor
        
        node.automaticallyManagesSubnodes = true
        
        node.addSubnode(self.SFNode)
        
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        
        reloadLayout()
        
        handleColorStyleCheck()
        
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().prefersLargeTitles = true
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.automaticallyAdjustsColorStyle == true { // This is just to ensure that all colors have been updated, some async methods need this
            updateColors()
        }
    }
    
    // touchesBegan: If you tap anywhere inside a view hide the keyboard
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // handleColorStyleCheck: Update colors and start a listener
    func handleColorStyleCheck() {
        if automaticallyAdjustsColorStyle == true {
            self.updateColors()
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    // automaticallyAdjustsColorStyleHandler: Creates a new NotificationCenter observer that calls handleBrightnessChange whenever the brightness change
    func automaticallyAdjustsColorStyleHandler() {
        if self.automaticallyAdjustsColorStyle == true {
            NotificationCenter.default.addObserver(self, selector: #selector(handleBrightnessChange), name: .UIScreenBrightnessDidChange, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    // handleBrightnessChange: Because of the way protocols work, you need to declare an extra @objc function to call updateColors() because it is not an @objc and a notificion can't keep track of it
    @objc final func handleBrightnessChange() {
        updateColors()
    }
    
    // showErrorAlert: Shows an alert with the alerts you added
    // - Parameters:
    //    title: Title of the alert you want to present
    //    errorDescription: Description of what is happening
    //    action: Action to perform once the user saw the alert
    public func showErrorAlert(title: String, errorDescription: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: errorDescription, preferredStyle: .alert) // Create a new UIAlertController
        actions.forEach { (action) in // Loop over all actions inside the array
            alert.addAction(action) // Add the current action
        }
        self.present(alert, animated: true, completion: nil) // Present the alert to the user
    }
    
    // reloadLayout: This method fixes the bug when the navigationBar/tabBar covers your main node, it does that by adding UIEdgeInsets to your SFNode, your could disable it by disabling automaticallyAdjustsLayoutInsets
    public func reloadLayout() {
        
        var topMargin: CGFloat = 0
        
        if automaticallyAdjustsLayoutInsets == true {
            
            // If navigation bar is hidden then don't do nothing
            if navigationController?.navigationBar.isHidden == false {
                
                // If navigationController is not nill then a top margin would be added to prevent navigation bar from hiding the current node
                topMargin = navigationController?.navigationBar.bounds.height ?? 0
                
                // If topMargin is not 0, then the navigation bar exist so you check if it's a regular size class or compact
                if topMargin != 0 {
                    
                    // Regular Size Class show a status bar so this space must be added to the top inset
                    if self.view.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
                        topMargin += UIApplication.shared.statusBarFrame.height
                    }
                }
                
            }
            
        }
                        
        // If tabBarController is not nill then a top margin would be added to prevent navigation bar from hiding the current node
        let bottomMargin = tabBarController?.tabBar.bounds.height ?? 0
        
        // Add the margin inside a layoutSpecBlock
        self.node.layoutSpecBlock = { constrainedSize in
            
            self.SFNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.0.bounds.width), height: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.0.bounds.height))
            
            let layoutWithInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: topMargin, left: 0, bottom: bottomMargin, right: 0), child: self.SFNode)
            
            return layoutWithInset
        }
        
    }
    
    // traitCollectionDidChange: Checks when the device rotates and reloadLayout()
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        reloadLayout()
    }
    
    // updateColors: Updates the colors to the corrects one
    public func updateColors() {
        
        if self.automaticallyAdjustsColorStyle == true {
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
                    
                })
            }
        }
        
    }
    
    // updateSubNodesColors: Updates SFNode's colorStyle and call updateColors(). Don't forget that SFNode is a subnode of your main node(the one that comes with ASViewController)
    public func updateSubNodesColors() {
        self.SFNode.updateColors()
    }
}












