//
//  SFSearchBar.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 13/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

@objc public protocol SFSearchBarDelegate: class {
    @objc optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
    @objc optional func textFieldDidBeginEditing(_ textField: UITextField) // became first responder
    @objc optional func textFieldShouldEndEditing(_ textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    @objc optional func textFieldDidEndEditing(_ textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    @objc optional func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    @objc optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    @objc optional func textFieldShouldClear(_ textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    @objc optional func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    @objc optional func cancelButtonDidTouch() // called when 'cancel' button has been pressed
}

open class SFSearchBar: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // delegate: Delegate that keeps track of the changes inside the searchBar
    open weak var delegate: SFSearchBarDelegate?
    
    // cancelButtonShouldBeVisible: Indicates if the cancel button is visible or not
    open var cancelButtonShouldBeVisible: Bool = false
        
    // textField: Main part of the searchBar, it is where the user writes what he wants to search
    open lazy var textField: SFTextField = {
        let node = SFTextField()
        node.placeholder = LocalizedString.shared.getSearch()
        node.leftPadding = 14
        node.style.flexGrow = 1.0
        return node
    }()
    
    // cancelButton: Cancel button used to stop searching
    open lazy var cancelButton: SFButtonNode = {
        let button = SFButtonNode()
        button.font = UIFont.systemFont(ofSize: 17)
        button.text = LocalizedString.shared.getCancel()
        return button
    }()
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 56)) // Set a default size for all searchBars
        textField.textField.delegate = self
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // layoutSpecThatFits: Layout all subnodes
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        textField.style.flexBasis = self.cancelButtonShouldBeVisible == true ? ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 126) : ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 32) // If cancel button is visible then textField should be smaller, if not then make it bigger
        
        textField.style.height = ASDimension(unit: ASDimensionUnit.points, value: 40)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [textField, cancelButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: stackLayout)
    }
    
    open override func updateColors() {
        
        if self.automaticallyAdjustsColorStyle == true {
            
            backgroundColor = self.colorStyle.getBackgroundColor()
            
            textField.lefImage = self.colorStyle.getSearchImage()
            
            updateSubNodesColors()
        }
    }
    
    // cancelButtonDidTouch: Executes whenever the user tap the cancel button
    @objc open func cancelButtonDidTouch() {
        textField.textField.text = ""
        textField.endEditing(force: true)
        delegate?.cancelButtonDidTouch?()
    }    
}

// MARK: FluidSearchBar Extension for UITextFieldDelegate
extension SFSearchBar: UITextFieldDelegate {
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if let delegate = delegate {
            if let result = delegate.textFieldShouldBeginEditing?(textField) {
                return result
            }
        }
        return true
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.cancelButtonShouldBeVisible = true
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
        
        delegate?.textFieldDidBeginEditing?(textField)
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        self.cancelButtonShouldBeVisible = false
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
        
        if let delegate = delegate {
            if let result = delegate.textFieldShouldEndEditing?(textField) {
                return result
            }
        }
        return true
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.cancelButtonShouldBeVisible = true
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
        
        delegate?.textFieldDidEndEditing?(textField)
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        self.cancelButtonShouldBeVisible = false
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
        
        delegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegate {
            if let result = delegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
                return result
            }
        }
        return true
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let delegate = delegate {
            if let result = delegate.textFieldShouldClear?(textField) {
                return result
            }
        }
        return true
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        
        if let delegate = delegate {
            if let result = delegate.textFieldShouldReturn?(textField) {
                return result
            }
        }
        return true
    }
}
