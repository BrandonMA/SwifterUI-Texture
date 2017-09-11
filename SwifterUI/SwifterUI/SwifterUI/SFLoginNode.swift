//
//  SFLoginNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 23/07/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFLoginNode: SFDisplayNode {
    
    // MARK: - Instance Properties
        
    open var shouldHaveFacebookButton: Bool = true
    open var shouldHaveTwitterButton: Bool = true
    open var shouldHaveGoogleButton: Bool = true
        
    // video: Optional background video
    open var video: AVAsset? {
        didSet {
            self.backgroundContentNode.asset = self.video
        }
    }
    
    // backgroundImage: Optional background image
    open var backgroundImage: UIImage? {
        didSet {
            self.backgroundContentNode.image = self.backgroundImage
        }
    }
    
    // logo: Logo that is going to be used
    open var logo: UIImage? {
        didSet {
            self.logoImageNode.image = self.logo
        }
    }
    
    // title: Title of your application
    open var title: String = "" {
        didSet {
            self.titleLabelNode.text = self.title
        }
    }
    
    // backgroundContentNode: Background node that show an optional video or image
    open lazy var backgroundContentNode: ASVideoNode = {
        let videoNode = ASVideoNode()
        videoNode.shouldAutoplay = true
        videoNode.shouldAutorepeat = true
        videoNode.muted = true
        return videoNode
    }()
    
    // logoImageNode: Node used to show the logo
    open lazy var logoImageNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.clipsToBounds = true
        imageNode.contentMode = .scaleAspectFit
        imageNode.backgroundColor = UIColor.clear
        return imageNode
    }()
    
    // titleLabelNode: Node used to show the title
    open lazy var titleLabelNode: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        let size: CGFloat = self.deviceType == .iphone ? 28 : 34
        label.font = UIFont.boldSystemFont(ofSize: size)
        return label
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
    
    open lazy var signInButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        button.textColor = UIColor.white
        button.text = LocalizedString.shared.getSignIn()
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.cornerRadius = 8
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
    
    open lazy var facebookButton: ASButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: false)
        SFAssets.imageOfFacebookIcon.tint(color: UIColor.white, alpha: 1.0, handler: { (image) in
            button.setImage(image, for: UIControlState.normal)
        })
        button.backgroundColor = SFAssets.facebookBlue
        button.cornerRadius = 26
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
    
    // newAccountLabel: Label at the left side of signUpButton
    open lazy var signUpButton: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        label.text = LocalizedString.shared.getNewAccount() + " " + LocalizedString.shared.getSignUp()
        label.font = UIFont.systemFont(ofSize: 17)
        label.extraAttributes[LocalizedString.shared.getSignUp()] = [SFTextAttributeName: SFTextType.button]
        return label
    }()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool){
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
    }
    
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        logoImageNode.style.preferredLayoutSize = deviceType == .ipad ? ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 256), height: ASDimension(unit: ASDimensionUnit.points, value: 256)) : ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: deviceType == .iphone ? 96 : 128), height: ASDimension(unit: ASDimensionUnit.points, value: deviceType == .iphone ? 96 : 128))
        
        signInButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let bottomButtonsLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 52), height: ASDimension(unit: ASDimensionUnit.points, value: 52))
        
        googleButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        facebookButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        twitterButton.style.preferredLayoutSize = bottomButtonsLayoutSize
        
        let multiplier: CGFloat = deviceType == .iphone ? 1.0 : 1.5
        let separators: [ASLayoutSpec] = [getStackSeparator(with: 16 * multiplier), getStackSeparator(with: 16 * multiplier), getStackSeparator(with: 16), getStackSeparator(with: 16 * multiplier), getStackSeparator(), getStackSeparator(with: 16)]
        
        let buttonStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [])
        
        if self.shouldHaveGoogleButton == true { buttonStack.children?.append(self.googleButton) }
        if self.shouldHaveFacebookButton == true { buttonStack.children?.append(self.facebookButton) }
        if self.shouldHaveTwitterButton == true { buttonStack.children?.append(self.twitterButton) }
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [logoImageNode, separators[0], titleLabelNode, separators[1], emailTextField, separators[2], passwordTextField, separators[3], signInButton, separators[4], buttonStack, separators[5], signUpButton])
        
        return addLoadingNode(to: ASInsetLayoutSpec(insets: UIEdgeInsets(top: deviceType == .iphone ? 52 : 64, left: deviceType == .ipad ? 128 : 16, bottom: 16, right: deviceType == .ipad ? 128 : 16), child: stackLayout))
    }
}
















