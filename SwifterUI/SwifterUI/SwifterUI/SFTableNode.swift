//
//  SFTableNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTableNode: ASTableNode, SFDisplayNodeColorStyle {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool
    
    // shouldHaveRefreshControl: Indicates if it should have a refresh control or not
    open var shouldHaveRefreshControl: Bool = false
    
    // refreshControl: UIRefreshControl added to your view.refreshControl, this is just for easier access
    open var refreshControl: UIRefreshControl?
    
    open var separatorColor: UIColor = UIColor.clear {
        didSet {
            self.view.separatorColor = self.separatorColor
        }
    }

    // MARK: - Initializers
    
    // Initialize your SFTableNode with a custom style
    // - Parameters:
    //   style: Set style of your tableview
    public init(style: UITableViewStyle, automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init(style: style)
    }
    
    public required convenience init(automaticallyAdjustsColorStyle: Bool) {
        self.init(style: UITableViewStyle.plain, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    public convenience init() {
        self.init(style: UITableViewStyle.plain, automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // didLoad: Called when your view is already loaded and ready to display
    open override func didLoad() {
        super.didLoad()
        updateColors()
        if self.shouldHaveRefreshControl == true {
            self.refreshControl = UIRefreshControl()
            self.view.refreshControl = self.refreshControl
        }
        self.view.backgroundView = UIView() // This is used to eliminate a weird bug with UISearchBar showing a gray background
    }
    
    // This method should be called after viewDidLoad if you are using a SFTableNode
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            updateSubNodesColors()
            self.refreshControl?.tintColor = self.colorStyle.getDetailColor()
            self.backgroundColor = self.colorStyle.getAlternativeBackgroundColor()
            self.separatorColor = self.colorStyle.getSeparatorColor()
            
            // This is going to loop through every section inside the table node and reload it with the correct color style on the main thread
            for i in 0...self.numberOfSections - 1 {
                for j in 0...self.numberOfRows(inSection: i) {
                    guard let cell = self.nodeForRow(at: IndexPath(row: j, section: i)) as? SFCellNode else { return }
                    cell.updateColors()
                }
            }
        }
    }
    
    // endRefreshing: Calls refreshControl's endRefreshing method
    open func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}













