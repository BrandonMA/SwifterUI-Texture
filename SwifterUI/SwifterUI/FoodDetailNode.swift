//
//  DetailNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodDetailNode: SFDisplayNode {
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        node.image = UIImage(named: "breakfast")
        return node
    }()
    
    lazy var titleNode: SFLabelNode = {
        let node = SFLabelNode(automaticallyAdjustsColorStyle: false)
        node.color = UIColor.white
        node.font = UIFont.boldSystemFont(ofSize: 22)
        node.aligment = .left
        node.text = "Full English Breakfast"
        return node
    }()
    
    lazy var mainTextNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                                                 attributes: [
                                                    NSForegroundColorAttributeName: UIColor.black,
                                                    NSFontAttributeName: UIFont.systemFont(ofSize: 15),
                                                    NSParagraphStyleAttributeName: paragraphStyle
            ])
        return node
    }()
    
    lazy var collectionNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 156, height: 156)
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.clipsToBounds = false
        return node
    }()
    
    lazy var eatenButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.cornerRadius = 8
        button.gradient = SFGradient(with: [UIColor(red: 255, green: 199, blue: 0).cgColor, UIColor(red: 255, green: 149, blue: 0).cgColor], direction: SFGradientDirection.vertical)
        button.text = "Eaten"
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.textColor = UIColor.white
        return button
    }()
    
    lazy var sadButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.cornerRadius = 8
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "sad"), for: UIControlState.normal)
        return button
    }()
    
    lazy var closeButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.cornerRadius = 16
        button.setImage(UIImage(named: "close"), for: UIControlState.normal)
        button.shouldHaveBackgroundBlur = true
        return button
    }()
    
    override func layout() {
        super.layout()
        
        self.sadButton.layer.shadowColor = UIColor.black.cgColor
        self.sadButton.layer.shadowOpacity = 0.15
        self.sadButton.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.sadButton.layer.shadowRadius = 23
        self.sadButton.layer.masksToBounds = false
        self.sadButton.layer.shadowPath = UIBezierPath(rect: self.eatenButton.bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let imageLayout = ASRatioLayoutSpec(ratio: 9/16, child: imageNode)
        
        let titleLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: -29, left: 16, bottom: 0, right: 0), child: titleNode)
        
        mainTextNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        mainTextNode.style.flexGrow = 1
        collectionNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        collectionNode.style.height = ASDimension(unit: ASDimensionUnit.points, value: 188)
        eatenButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 92), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        sadButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 44), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let buttonStackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [eatenButton, sadButton])
        
        let contentLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16), child: ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [mainTextNode, collectionNode, buttonStackLayout]))
        contentLayout.style.flexGrow = 1
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [imageLayout, titleLayout, getStackSeparator(with: 16), contentLayout])
        
        closeButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 32), height: ASDimension(unit: ASDimensionUnit.points, value: 32))
        let closeButtonLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20), child: ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.end, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: self.closeButton))
        
        return ASOverlayLayoutSpec(child: stackLayout, overlay: closeButtonLayout)
    }
    
}



















