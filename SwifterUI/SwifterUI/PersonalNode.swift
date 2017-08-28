//
//  PersonalNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class PersonalNode: WalkthroughNode<ASDisplayNode> {
    
    // nameTextField: Node where the user's name is saved
    open lazy var heightTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: false)
        textField.updateColors()
        textField.leftPadding = 8
        textField.placeholder = "Height"
        textField.backgroundColor = SFAssets.whiteTextField
        textField.placeholderColor = SFAssets.lightGray
        textField.textColor = SFAssets.black
        textField.clearButtonColor = SFAssets.black
        return textField
    }()
    
    // emailTextField: Node where the user's email is saved
    open lazy var ageTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: false)
        textField.updateColors()
        textField.leftPadding = 8
        textField.placeholder = "Age"
        textField.backgroundColor = SFAssets.whiteTextField
        textField.placeholderColor = SFAssets.lightGray
        textField.textColor = SFAssets.black
        textField.clearButtonColor = SFAssets.black
        return textField
    }()
    
    // passwordTextField: Node where the user's password is saved
    open lazy var weightTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: false)
        textField.updateColors()
        textField.leftPadding = 8
        textField.placeholder = "Weight"
        textField.backgroundColor = SFAssets.whiteTextField
        textField.placeholderColor = SFAssets.lightGray
        textField.textColor = SFAssets.black
        textField.clearButtonColor = SFAssets.black
        return textField
    }()
    
    init() {
        super.init(with: ASDisplayNode())
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 245, green: 78, blue: 162).cgColor, UIColor(red: 255, green: 118, blue: 118).cgColor], direction: SFGradientDirection.vertical)
        bottomButton.gradient = SFGradient(with: [UIColor(red: 255, green: 118, blue: 118).cgColor, UIColor(red: 245, green: 78, blue: 162).cgColor], direction: SFGradientDirection.vertical)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
    
    override func didLoad() {
        self.middleNode.backgroundColor = UIColor.clear
    }
    
    override func layout() {
        self.middleNode.layer.shadowColor = nil
        self.middleNode.layer.shadowOpacity = 0
        self.middleNode.layer.shadowOffset = CGSize.zero
        self.middleNode.layer.shadowRadius = 0
        self.middleNode.layer.shadowPath = nil
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        topGradientNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 144))
        maskTopGradient(constrainedSize: constrainedSize)
                
        bottomButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 32), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let textFieldsLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 24, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [heightTextField, ageTextField, weightTextField]))
        
        let layoutSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [topGradientNode, getStackSeparator(with: 24), textFieldsLayout , getStackSeparator(), bottomButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: self.titleHeader == "" ? 0: 8, left: 0, bottom: 24, right: 0), child: layoutSpec)
    }
}

