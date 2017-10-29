//
//  SFSignUpNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFSignUpNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open var shouldHaveProfilePicture: Bool = true
    open var shouldHaveFacebookButton: Bool = true
    open var shouldHaveTwitterButton: Bool = true
    open var shouldHaveGoogleButton: Bool = true
        
    open lazy var dismissButton: SFDismissButton = {
        let node = SFDismissButton(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    open lazy var profilePictureNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        node.cornerRadius = self.deviceType == .ipad ? 128 : 64
        return node
    }()
    
    // nameTextField: Node where the user's name is saved
    open lazy var nameTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        textField.lefImage = SFAssets.imageOfPersonIcon
        textField.leftPadding = 8
        textField.placeholder = LocalizedString.shared.getUsername()
        textField.leftViewSize = CGSize(width: 18, height: 18)
        return textField
    }()
    
    // emailTextField: Node where the user's email is saved
    open lazy var emailTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        textField.lefImage = SFAssets.imageOfMailIcon
        textField.leftPadding = 8
        textField.placeholder = LocalizedString.shared.getEmail()
        textField.leftViewSize = CGSize(width: 21, height: 14)
        return textField
    }()
    
    // passwordTextField: Node where the user's password is saved
    open lazy var passwordTextField: SFTextField = {
        let textField = SFTextField(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        textField.lefImage = SFAssets.imageOfLockIcon
        textField.leftPadding = 8
        textField.placeholder = LocalizedString.shared.getPassword()
        textField.leftViewSize = CGSize(width: 14, height: 18)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    open lazy var signUpButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.textColor = UIColor.white
        button.text = LocalizedString.shared.getSignUp()
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.cornerRadius = 8
        return button
    }()
    
    open lazy var facebookButton: ASButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        SFAssets.imageOfFacebookIcon.tint(color: UIColor.white, alpha: 1.0, handler: { (image) in
            button.setImage(image, for: UIControlState.normal)
        })
        button.backgroundColor = SFAssets.facebookBlue
        button.cornerRadius = 26
        return button
    }()
    
    open lazy var googleButton: ASButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.setImage(SFAssets.imageOfGoogleIcon, for: .normal)
        button.backgroundColor = UIColor.white
        button.cornerRadius = 26
        button.borderColor = SFAssets.whiteTextField.cgColor
        button.borderWidth = 1
        return button
    }()
    
    open lazy var twitterButton: ASButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        SFAssets.imageOfTwitterIcon.tint(color: UIColor.white, alpha: 1.0, handler: { (image) in
            button.setImage(image, for: UIControlState.normal)
        })
        button.backgroundColor = SFAssets.twitterBlue
        button.cornerRadius = 26
        return button
    }()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool){
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        self.cornerRadius = 16 // This is not going to be visible until the animation
    }
    
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        dismissButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 12))
        
        profilePictureNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: self.deviceType == .ipad ? 256:128), height: ASDimension(unit: ASDimensionUnit.points, value: self.deviceType == .ipad ? 256:128))
        
        signUpButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let bottomButtonsLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 52), height: ASDimension(unit: ASDimensionUnit.points, value: 52))
        
        googleButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        facebookButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        twitterButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        
        let buttonStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [])
        
        if self.shouldHaveGoogleButton == true { buttonStack.children?.append(self.googleButton) }
        if self.shouldHaveFacebookButton == true { buttonStack.children?.append(self.facebookButton) }
        if self.shouldHaveTwitterButton == true { buttonStack.children?.append(self.twitterButton) }
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: deviceType == .ipad ? 32:16, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [dismissButton])
        
        if self.shouldHaveProfilePicture == true {
            stackLayout.children?.append(profilePictureNode)
        }
        
        stackLayout.children?.append(nameTextField)
        stackLayout.children?.append(emailTextField)
        stackLayout.children?.append(passwordTextField)
        stackLayout.children?.append(signUpButton)
        stackLayout.children?.append(getStackSeparator())
        stackLayout.children?.append(buttonStack)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: deviceType == .iphone ? 12 : 16, left: deviceType == .ipad ? 128 : 16, bottom: 16, right: deviceType == .ipad ? 128 : 16), child: stackLayout)
    }
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            super.updateColors()
            profilePictureNode.backgroundColor = self.colorStyle.getTextFieldColor()
        }
    }
    
}












