//
//  SFTableNodeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFTableNodeController: SFViewController<SFTableNode>, ASTableDataSource, ASTableDelegate {
    
    // MARK: - Instance Properties
    
    // shouldHaveSearchBar: Indicates if it should have a search bar available or not
    open var shouldHaveSearchBar: Bool = false
    
    // resultsController: Controller used to display results
    open var resultsController: UIViewController? = nil
    
    // searchController: Search Controller used if you want to add a search bar, it is self by default
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(SFTableNode: SFTableNode, automaticallyAdjustsColorStyle: Bool) {
        
        super.init(SFNode: SFTableNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.SFNode.tableNode.delegate = self
        
        self.SFNode.tableNode.dataSource = self
        
        self.automaticallyAdjustsLayoutInsets = false
        
        self.node.backgroundColor = self.SFNode.backgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    open override func viewDidLoad() {
        handleSearchController()
    }
    
    // handleSearchController: Check if it should have a searchController or not
    func handleSearchController() {
        if shouldHaveSearchBar == true {
            if let controller = self.resultsController {
                searchController = UISearchController(searchResultsController: controller)
            }
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.searchBarStyle = .minimal
            searchController.hidesNavigationBarDuringPresentation = false
            
            if #available(iOS 11.0, *) {
//                self.navigationItem.largeTitleDisplayMode = .always
//                self.navigationItem.searchController = searchController
                self.navigationController?.definesPresentationContext = true
            } else {
                SFNode.tableNode.view.tableHeaderView = searchController.searchBar
                self.definesPresentationContext = true
            }
        }
    }
    
    // updateColors: Updates the colors to the corrects one
    public override func updateColors() {
        super.updateColors()
        searchController.searchBar.barStyle = self.colorStyle.getSearchBarStyle()
        searchController.searchBar.tintColor = self.colorStyle.getInteractiveColor()
        searchController.searchBar.keyboardAppearance = self.colorStyle.getKeyboardAppearence()
    }
    
    open func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 0
    }
    
    open func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    open func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        return { SFCellNode() }
        
    }
}
