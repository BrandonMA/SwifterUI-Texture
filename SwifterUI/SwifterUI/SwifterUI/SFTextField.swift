//
//  SFTextField.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 06/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFTextFieldView: UITextField {
    
    var clearButtonColor: UIColor = UIColor.clear {
        didSet {
            layoutSubviews()
        }
    }
    var cachedColor: UIColor = UIColor.clear
    var cachedImage: UIImage?
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        tintClearButton() // This is the only place where you can access the clear button
    }
    
    open func tintClearButton() {
        for view in subviews {
            if let button = view as? UIButton {
                if cachedImage == nil {
                    cachedImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                } else if cachedColor != clearButtonColor {
                    cachedImage = button.image(for: .highlighted)?.tint(color: clearButtonColor, alpha: 1)
                    cachedColor = clearButtonColor
                }
                
                guard let cachedImage = cachedImage else { return }
                button.setImage(cachedImage, for: .normal)
            }
        }
    }
}

// FluidTextField: Creates a FluidDisplayNode with a UITextField as the backing view
open class SFTextField: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // textField: Backing UITextField for your node
    open let textField: SFTextFieldView
    
    // textColor: Color that your text is going to be
    open var textColor: UIColor = UIColor.clear {
        didSet {
            textField.textColor = self.textColor
        }
    }
    
    // textFieldTintColor: Tint color used in your textField
    open var textFieldTintColor: UIColor = SFAssets.blue {
        didSet {
            textField.tintColor = self.textFieldTintColor
        }
    }
    
    // placeholder: Text that is showed before the user types anything, by default it is clear by default
    open var placeholder: String = "" {
        didSet {
            setPlaceHolder()
        }
    }
    
    // placeholderColor: Color of your placeholder
    open var placeholderColor: UIColor = UIColor.clear {
        didSet {
            setPlaceHolder()
        }
    }
    
    // isSecureTextEntry: Property for textFields that are used for passwords, it is false by default
    open var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = self.isSecureTextEntry
        }
    }
    
    // font: Font that is going to be used for both your placeholder and user's text
    open var font: UIFont {
        didSet {
            textField.font = self.font
        }
    }
    
    // leftPadding: Left space added before your placeholder and the text that is typed by the user, by default it's 0
    open var leftPadding: CGFloat = 0.0 {
        didSet {
            addLeftView()
        }
    }
    
    // lefImage: Left image used in your textField, by default it is nil
    open var lefImage: UIImage? = nil {
        didSet {
            addLeftView()
        }
    }
    
    // leftViewMode: Defines when the left view should be visible
    open var leftViewMode: UITextFieldViewMode =  UITextFieldViewMode.always {
        didSet {
            addLeftView()
        }
    }
    
    // leftViewMode: Set the size of the left view
    open var leftViewSize: CGSize = CGSize(width: 14, height: 14) {
        didSet {
            addLeftView()
        }
    }
    
    // rightPadding: Right space added after your placeholder and the text that is typed by the user, by default it's 0
    open var rightPadding: CGFloat = 0.0 {
        didSet {
            addRightView()
        }
    }
    
    // rightImage: Right image used in your textField, by default it is nil
    open var rightImage: UIImage? = nil {
        didSet {
            addRightView()
        }
    }
    
    // rightViewMode: Defines when the right view should be visible
    open var rightViewMode: UITextFieldViewMode = UITextFieldViewMode.unlessEditing {
        didSet {
            addRightView()
        }
    }
    
    // rightViewMode: Set the size of the right view
    open var rightViewSize: CGSize = CGSize(width: 14, height: 14) {
        didSet {
            addRightView()
        }
    }
    
    open var clearButtonColor: UIColor = UIColor.black {
        didSet {
            self.textField.clearButtonColor = self.clearButtonColor
        }
    }
        
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public required init(automaticallyAdjustsColorStyle: Bool) {

        textField = SFTextFieldView() // Creates a new UITextField for your backing view
        self.font = UIFont.systemFont(ofSize: 17)
        
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.setViewBlock { () -> UIView in // Creates the backing view block
            self.textField.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin] // Create the autoresizingMask that fills all your node
            return self.textField
        }
        
        self.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        self.style.height = ASDimension(unit: ASDimensionUnit.points, value: 40) // Set a default height of 40
        self.cornerRadius = 8 // Set a default corner radius of 8
        
        textField.clearButtonMode = .whileEditing // Automatically adds a clearButtonMode while editing
        
        updateColors()
        
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // addLeftView: Add a view at the left side of your textField
    private func addLeftView() {
        
        let totalPadding: CGFloat = lefImage != nil ? self.leftPadding + self.leftViewSize.width + self.leftPadding : self.leftPadding
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: totalPadding, height: self.leftViewSize.height))
        paddingView.image = self.lefImage
        paddingView.contentMode = .scaleAspectFit
        textField.leftView = paddingView
        textField.leftViewMode = self.leftViewMode
    }
    
    // addRightView: Add a view at the right side of your textField
    private func addRightView() {
        
        let totalPadding: CGFloat = rightImage != nil ? self.rightPadding + self.rightViewSize.width + self.rightPadding : self.rightPadding
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: totalPadding, height: self.rightViewSize.height))
        paddingView.image = self.rightImage
        paddingView.contentMode = .scaleAspectFit
        textField.rightView = paddingView
        textField.rightViewMode = UITextFieldViewMode.unlessEditing
    }
    
    // setPlaceHolder: Set the NSAttributedString for the placeholder automatically
    private func setPlaceHolder() {
        textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: [NSForegroundColorAttributeName: self.placeholderColor, NSFontAttributeName: self.font])
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open override func updateColors() {
        
        if self.automaticallyAdjustsColorStyle == true {
            
            clearButtonColor = self.colorStyle.getDetailColor()
            
            textField.backgroundColor = self.colorStyle.getTextFieldColor()
            
            textFieldTintColor = self.colorStyle.getInteractiveColor()
            
            textField.keyboardAppearance = self.colorStyle.getKeyboardAppearence()
            
            placeholderColor = self.colorStyle.getPlaceholderColor()
            
            textField.textColor = self.colorStyle.getMainColor()
            
            updateSubNodesColors()
            
        }
    }
    
    // endEditing: Convenience method to access the textField's one
    public func endEditing(force: Bool) {
        self.textField.endEditing(force)
    }
}















