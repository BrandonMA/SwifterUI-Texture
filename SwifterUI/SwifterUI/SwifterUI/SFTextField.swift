//
//  SFTextField.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 06/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFTextField: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open var textColor: UIColor = UIColor.black {
        didSet {
            self.setAttributedText()
        }
    }
    
    open var font: UIFont {
        didSet {
            self.setAttributedText()
            self.setPlaceHolder()
        }
    }
    
    open var text: String {
        get {
            if let text = self.textField.text {
                self.text = text
                return text
            } else {
                return ""
            }
        } set(newValue) {
            self.textField.text = newValue
            self.setAttributedText()
        }
    }
        
    open var aligment: NSTextAlignment = .left {
        didSet {
            self.setAttributedText()
            self.setPlaceHolder()
        }
    }
    
    open var extraAttributes: [String : TextAttributes] = [:]
    
    // textField: Backing UITextField for your node
    open let textField: SFTextFieldView
    
    // textFieldTintColor: Tint color used in your textField
    open var textFieldTintColor: UIColor = SFAssets.blue { didSet { textField.tintColor = self.textFieldTintColor } }
    
    // placeholder: Text that is showed before the user types anything, by default it is clear by default
    open var placeholder: String = "" {
        didSet {
            self.setPlaceHolder()
        }
    }
    
    // placeholderColor: Color of your placeholder
    open var placeholderColor: UIColor = UIColor.clear {
        didSet {
            self.setPlaceHolder()
        }
    }
    
    // isSecureTextEntry: Property for textFields that are used for passwords, it is false by default
    open var isSecureTextEntry: Bool = false { didSet { textField.isSecureTextEntry = self.isSecureTextEntry } }

    // leftPadding: Left space added before your placeholder and the text that is typed by the user, by default it's 0
    open var leftPadding: CGFloat = 0.0 { didSet { addLeftView() } }
    
    // lefImage: Left image used in your textField, by default it is nil
    open var lefImage: UIImage? = nil { didSet { addLeftView() } }
    
    // leftViewMode: Defines when the left view should be visible
    open var leftViewMode: UITextFieldViewMode =  UITextFieldViewMode.always { didSet { addLeftView() } }
    
    // leftViewMode: Set the size of the left view
    open var leftViewSize: CGSize = CGSize(width: 14, height: 14) { didSet { addLeftView() } }
    
    // rightPadding: Right space added after your placeholder and the text that is typed by the user, by default it's 0
    open var rightPadding: CGFloat = 0.0 { didSet { addRightView() } }
    
    // rightImage: Right image used in your textField, by default it is nil
    open var rightImage: UIImage? = nil { didSet { addRightView() } }
    
    // rightViewMode: Defines when the right view should be visible
    open var rightViewMode: UITextFieldViewMode = UITextFieldViewMode.unlessEditing { didSet { addRightView() } }
    
    // rightViewMode: Set the size of the right view
    open var rightViewSize: CGSize = CGSize(width: 14, height: 14) { didSet { addRightView() } }
    
    // clearButtonColor: Color of the clearbutton, to see implementation check textField's clearButtonColor properties
    open var clearButtonColor: UIColor = UIColor.black { didSet { self.textField.clearButtonColor = self.clearButtonColor } }
        
    // MARK: - Initializers

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
    
    open override func didLoad() {
        setAttributedText()
        setPlaceHolder()
    }
    
    open override func updateColors() {
        
        if self.automaticallyAdjustsColorStyle == true {
            
            if #available(iOS 11.0, *) {
                clearButtonColor = self.colorStyle.getDetailColor()
            } else {
                clearButtonColor = self.colorStyle.getDetailColor().withAlphaComponent(0.3)
            }
            
            textField.backgroundColor = self.colorStyle.getTextFieldColor()
            
            textFieldTintColor = self.colorStyle.getInteractiveColor()
            
            textField.keyboardAppearance = self.colorStyle.getKeyboardAppearence()
            
            placeholderColor = self.colorStyle.getPlaceholderColor()
            
            self.textColor = self.colorStyle.getMainColor()
            
            updateSubNodesColors()
        }
    }
}

extension SFTextField {
    
    // setPlaceHolder: Set the NSAttributedString for the placeholder automatically
    public func setPlaceHolder() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholder,
                                                           attributes: [
                                                            NSForegroundColorAttributeName: self.placeholderColor,
                                                            NSFontAttributeName: self.font,
                                                            NSParagraphStyleAttributeName: paragraphStyle])
    }

    // addLeftView: Add a view at the left side of your textField
    public func addLeftView() {
        
        let totalPadding: CGFloat = lefImage != nil ? self.leftPadding + self.leftViewSize.width + self.leftPadding : self.leftPadding
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: totalPadding, height: self.leftViewSize.height))
        paddingView.image = self.lefImage
        paddingView.contentMode = .scaleAspectFit
        textField.leftView = paddingView
        textField.leftViewMode = self.leftViewMode
        
    }
    
    // addRightView: Add a view at the right side of your textField
    public func addRightView() {
        
        let totalPadding: CGFloat = rightImage != nil ? self.rightPadding + self.rightViewSize.width + self.rightPadding : self.rightPadding
        
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: totalPadding, height: self.rightViewSize.height))
        paddingView.image = self.rightImage
        paddingView.contentMode = .scaleAspectFit
        textField.rightView = paddingView
        textField.rightViewMode = UITextFieldViewMode.unlessEditing
    }
    
    // endEditing: Convenience method to access the textField's one
    public func endEditing(force: Bool) {
        self.textField.endEditing(force)
    }
}

extension SFTextField: SFTextContainer {
    
    public func setAttributedText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        self.textField.textColor = self.textColor
        self.textField.defaultTextAttributes = [
            NSForegroundColorAttributeName: self.textColor,
            NSFontAttributeName: self.font,
            NSParagraphStyleAttributeName: paragraphStyle]
    }
    
}










