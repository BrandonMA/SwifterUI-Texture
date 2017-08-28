//
//  FoodNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodNode: WalkthroughNode<FoodMiddleNode> {
    
    lazy var heartButton: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "heart"), for: UIControlState.normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var cancelButton: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "cancel"), for: UIControlState.normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var addButton: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "add"), for: UIControlState.normal)
        button.imageNode.contentMode = .scaleAspectFit
        return button
    }()
    
    init() {
        super.init(with: FoodMiddleNode())
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 0, green: 200, blue: 83).cgColor, UIColor(red: 0, green: 230, blue: 139).cgColor], direction: SFGradientDirection.vertical)
        bottomButton.gradient = SFGradient(with: [UIColor(red: 0, green: 230, blue: 139).cgColor, UIColor(red: 0, green: 200, blue: 83).cgColor], direction: SFGradientDirection.vertical)
        
        heartButton.addTarget(self, action: #selector(heartButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
    
    func heartButtonDidTouch() {
        animateFoodChange(for: self.heartButton)
    }
    
    func cancelButtonDidTouch() {
        animateFoodChange(for: self.cancelButton)
    }
    
    func addButtonDidTouch() {
        animateFoodChange(for: self.addButton)
    }
    
    func animateFoodChange(for button: CircleButton) {
        let initialZPosition = button.zPosition
        button.zPosition += 200
        
        UIView.animate(withDuration: 0.2, animations: {
            button.view.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        }) { (finishedGrowing) in
            UIView.animate(withDuration: 0.2, animations: {
                button.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (finished) in
                button.zPosition = initialZPosition
            }
        }
        
        UIView.transition(with: self.middleNode.imageNode.view, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.middleNode.imageNode.image = UIImage(named: "egg")
        }, completion: nil)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        topGradientNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 144))
        maskTopGradient(constrainedSize: constrainedSize)
        
        middleNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 48), height: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 48))
        
        heartButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 64), height: ASDimension(unit: ASDimensionUnit.points, value: 64))
        
        cancelButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 64), height: ASDimension(unit: ASDimensionUnit.points, value: 64))
        
        addButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 64), height: ASDimension(unit: ASDimensionUnit.points, value: 64))
        
        bottomButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 32), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let buttonStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: -32, left: 0, bottom: 0, right: 0), child: ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: self.deviceType == .iphone ? 20:28, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [cancelButton, heartButton, addButton]))
        
        let layoutSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [topGradientNode, getStackSeparator(), middleNode, buttonStackLayout, getStackSeparator(), bottomButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: self.titleHeader == "" ? 0: 8, left: 0, bottom: 24, right: 0), child: layoutSpec)
    }
    
}




















