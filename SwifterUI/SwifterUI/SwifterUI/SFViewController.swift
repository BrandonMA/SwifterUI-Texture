//
//  SFViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import AVKit

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
    
    open var automaticallyTintNavigationBar: Bool = false {
        didSet {
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    // preferredStatusBarStyle: Override the preferred status bar style with an colorStyle's getStatusBarStyle method that automatically return the correct statusbarstyle
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    // prefersStatusBarHidden: Override the preferred status bar hidden with a dynamic way of set it
    open override var prefersStatusBarHidden: Bool {
        return self.statusBarIsHidden
    }
    
    // statusBarStyle: Dynamic way to change preferredStatusBarStyle, use this instead of override preferredStatusBarStyle
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // statusBarIsHidden: Dynamic way to change prefersStatusBarHidden, use this instead of override prefersStatusBarHidden
    open var statusBarIsHidden: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // shouldHaveSearchBar: Indicates if it should have a search bar available or not
    open var shouldHaveSearchBar: Bool = false
    
    // resultsController: Controller used to display results
    open var resultsController: UIViewController? = nil
    
    // searchController: Search Controller used if you want to add a search bar, it is self by default
    open var searchController: UISearchController? = nil
        
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
        
        self.automaticallyTintNavigationBar = automaticallyAdjustsColorStyle
        
        self.node.layoutSpecBlock = { node, constrainedSize in
            self.SFNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .points, value: constrainedSize.max.width), height: ASDimension(unit: .points, value: constrainedSize.max.height))
            
            return ASCenterLayoutSpec(horizontalPosition: .start, verticalPosition: .start, sizingOption: .minimumSize, child: self.SFNode)
        }
        
        handleColorStyleCheck()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        handleSearchController()
    }
    
    // handleSearchController: Check if it should have a searchController or not
    open func handleSearchController() {
        if shouldHaveSearchBar == true {
            if #available(iOS 11.0, *) {
                if let controller = self.resultsController {
                    searchController = UISearchController(searchResultsController: controller)
                } else {
                    searchController = UISearchController(searchResultsController: nil)
                }
            
                searchController?.dimsBackgroundDuringPresentation = false
                searchController?.searchBar.searchBarStyle = .minimal
                searchController?.hidesNavigationBarDuringPresentation = false
            
                self.navigationController?.definesPresentationContext = true
                self.navigationItem.searchController = self.searchController!
            }
        }
    }
    
    // handleBrightnessChange: Because of the way protocols work, you need to declare an extra @objc function to call updateColors() because it is not an @objc and a notificion can't keep track of it
    @objc final func handleBrightnessChange() {
        if currentColorStyle != self.colorStyle || self.currentColorStyle == nil {
            updateColors()
        }
    }
    
    // MARK: - SFColorController
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            Dispatch.addAsyncTask(to: DispatchLevel.main) {
                UIView.animate(withDuration: 0.3, animations: {
                   
                    // This is called first so your SFNode(a subnode of your main node) is updated first, then all it's subnodes.
                    self.updateSubNodesColors()
                    
                    // Once your SFNode is updated your main node(the one that comes with ASViewController) changes it's color to the correct one. This is make at the end because the main node should never be visible.
                    self.node.backgroundColor = self.SFNode.backgroundColor
                    
                    if self.automaticallyTintNavigationBar == true {
                        self.navigationController?.navigationBar.barStyle = self.colorStyle.getNavigationBarStyle()
                        self.navigationController?.navigationBar.tintColor = self.colorStyle.getInteractiveColor()
                    }
                    
                    self.statusBarStyle = self.colorStyle.getStatusBarStyle()
                    self.setNeedsStatusBarAppearanceUpdate()
                    
                    self.currentColorStyle = self.colorStyle
                    
                    self.searchController?.searchBar.barStyle = self.colorStyle.getSearchBarStyle()
                    self.searchController?.searchBar.tintColor = self.colorStyle.getInteractiveColor()
                    self.searchController?.searchBar.keyboardAppearance = self.colorStyle.getKeyboardAppearence()
                    
                })
            }
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



























