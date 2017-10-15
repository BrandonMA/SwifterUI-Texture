//
//  FoursquareNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoursquareNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    lazy var mapNode: ASMapNode = {
        let mapNode = ASMapNode()
        mapNode.isLiveMap = true
        mapNode.mapView?.showsUserLocation = true
        return mapNode
    }()
    
    lazy var searchBar: SFSearchBar = {
        let searchBar = SFSearchBar(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return searchBar
    }()
    
    lazy var tableNode: SFTableNode = {
        let tableNode = SFTableNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        tableNode.allowsSelection = false
        return tableNode
    }()
    
    // MARK: - Instance Methods
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        tableNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        tableNode.style.flexGrow = 1.0
        let ratioLayout = ASRatioLayoutSpec(ratio: 9/16, child: mapNode)
        let searchBarLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: searchBar)
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [ratioLayout, searchBarLayout, tableNode])
        return stackLayout
    }
}
