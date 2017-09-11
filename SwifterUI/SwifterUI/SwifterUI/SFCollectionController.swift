//
//  SFCollectionController.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 06/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFCollectionController: SFViewController<SFCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
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
    public init(SFCollectionNode: SFCollectionNode, automaticallyAdjustsColorStyle: Bool) {
        
        super.init(SFNode: SFCollectionNode, automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.SFNode.delegate = self
        
        self.SFNode.dataSource = self
        
        self.automaticallyAdjustsLayoutInsets = false
        
        self.node.backgroundColor = self.SFNode.backgroundColor
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
            if let controller = self.resultsController {
                searchController = UISearchController(searchResultsController: controller)
            }
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.searchBarStyle = .minimal
            searchController.hidesNavigationBarDuringPresentation = false
            
            if #available(iOS 11.0, *) {
                self.navigationController?.definesPresentationContext = true
            }
        }
    }
    
    // updateColors: Updates the colors to the corrects one
    open override func updateColors() {
        super.updateColors()
        searchController.searchBar.barStyle = self.colorStyle.getSearchBarStyle()
        searchController.searchBar.tintColor = self.colorStyle.getInteractiveColor()
        searchController.searchBar.keyboardAppearance = self.colorStyle.getKeyboardAppearence()
    }
    
    // MARK: - ASCollectionDataSource
    
    open func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 0
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    open func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { SFCellNode() }
    }
}
























