//
//  SFTableNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTableNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open override var backgroundColor: UIColor? {
        didSet {
            self.tableNode.backgroundColor = self.backgroundColor
        }
    }
    
    // shouldHaveRefreshControl: Indicates if it should have a refresh control or not
    open var shouldHaveRefreshControl: Bool = false
    
    // refreshControl: UIRefreshControl added to your view.refreshControl, this is just for easier access
    open var refreshControl: UIRefreshControl?
    
    // isFetching: Indicates if it's fetching data, if true then show a FluidActivityNode
    open var isFetching: Bool = false
    
    open var separatorColor: UIColor = UIColor.clear {
        didSet {
            self.tableNode.view.separatorColor = self.separatorColor
        }
    }
    
    weak var dataSource: ASTableDataSource? {
        didSet {
            self.tableNode.dataSource = self.dataSource
        }
    }
    
    weak var delegate: ASTableDelegate? {
        didSet {
            self.tableNode.delegate = self.delegate
        }
    }
    
    // MARK: - Initializers
    
    // Initialize your FluidTableNode with a custom style
    // - Parameters:
    //   style: Set style of your tableview
    public init(style: UITableViewStyle, automaticallyAdjustsColorStyle: Bool) {
        self.tableNode = ASTableNode(style: style)
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    public required convenience init(automaticallyAdjustsColorStyle: Bool) {
        self.init(style: UITableViewStyle.plain, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    public convenience required init() {
        self.init(style: UITableViewStyle.plain, automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Subnodes
    
    // tableNode: This is an instance of a table node with some UI modifications for convenience
    open var tableNode: ASTableNode
    
    // MARK: - Instance Methods
    
    // didLoad: Called when your view is already loaded and ready to display
    open override func didLoad() {
        super.didLoad()
        if self.shouldHaveRefreshControl == true {
            self.refreshControl = UIRefreshControl()
            self.tableNode.view.refreshControl = self.refreshControl
        }
        self.tableNode.view.backgroundView = UIView() // This is used to eliminate a weird bug with UISearchBar showing a gray background
    }
    
    // layoutSpecThatFits: Layout all subnodes
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
                
        self.tableNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        self.tableNode.style.height = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [tableNode])
    }
    
    // This method should be called after viewDidLoad if you are using a SFTableNode
    open override func updateColors() {
        super.updateColors()
        updateSubNodesColors()
        self.refreshControl?.tintColor = self.colorStyle.getDetailColor()
        self.tableNode.backgroundColor = self.colorStyle.getAlternativeBackgroundColor()
        self.separatorColor = self.colorStyle.getSeparatorColor()
        
        // This is going to loop through every section inside the table node and reload it with the correct color style on the main thread
        for i in 0...self.tableNode.numberOfSections - 1 {
            let indexSet = IndexSet(integer: i)
            self.tableNode.reloadSections(indexSet, with: UITableViewRowAnimation.fade) // Reload all the sections with a fade animation
        }
    }
    
    // endRefreshing: Calls refreshControl's endRefreshing method
    open func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}













