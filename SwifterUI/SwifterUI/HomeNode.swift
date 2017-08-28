//
//  HomeNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class HomeNode: ZipUpBaseNode {
    
    lazy var collectionNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 68, height: UIScreen.main.bounds.width - 68)
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 0, left: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 68)) / 2, bottom: 0, right: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width - 68)) / 2)
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.view.showsHorizontalScrollIndicator = false
        return node
    }()
    
    lazy var sophieButton: ASButtonNode = {
        let button = ASButtonNode()
        button.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0, height: 14)
        button.layer.shadowRadius = 23
        return button
    }()
    
    init() {
        super.init(automaticallyAdjustsColorStyle: false)
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 255, green: 149, blue: 0).cgColor, UIColor(red: 255, green: 199, blue: 0).cgColor], direction: SFGradientDirection.vertical)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        sophieButton.layer.shadowPath = UIBezierPath(rect: self.sophieButton.bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        topGradientNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 144))
        self.maskTopGradient(constrainedSize: constrainedSize)
        
        collectionNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        collectionNode.style.flexGrow = 1
        
        sophieButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 60), height: ASDimension(unit: ASDimensionUnit.points, value: 60))
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 24, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [topGradientNode, collectionNode, sophieButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: self.titleHeader == "" ? 0: 8, left: 0, bottom: 24, right: 0), child: stackLayout)
        
    }
    
}


















