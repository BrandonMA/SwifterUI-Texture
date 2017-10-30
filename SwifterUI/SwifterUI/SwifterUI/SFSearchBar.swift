//
//  SFSearchBar.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 13/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

@objc public protocol SFSearchBarDelegate: class {
    func didType(searchBar: SFSearchBar, text: String)
    func cancelButtonDidTouch(searchBar: SFSearchBar)
}

open class SFSearchBar: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // delegate: Delegate that keeps track of the changes inside the searchBar
    open weak var delegate: SFSearchBarDelegate?
    
    // cancelButtonIsVisible: Indicates if the cancel button is visible or not
    open var cancelButtonIsVisible: Bool = false
        
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
        self.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 52)) // Set a default size for all searchBars
        textField.textField.delegate = self
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.clipsToBounds = true
        self.textField.textField.addTarget(self, action: #selector(didType), for: UIControlEvents.editingChanged)
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // layoutSpecThatFits: Layout all subnodes
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        textField.style.flexBasis = self.cancelButtonIsVisible == true ? ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width - 94) : ASDimension(unit: ASDimensionUnit.points, value: constrainedSize.max.width) // If cancel button is visible then textField should be smaller, if not then make it bigger
        
        textField.style.height = ASDimension(unit: ASDimensionUnit.points, value: 44)
        
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.horizontal, spacing: 16, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [textField, cancelButton, getStackSeparator(with: self.cancelButtonIsVisible == true ? 16 : 0)])
        
        return stackLayout
    }
    
    // didType: Called whenever the user type or delete something
    @objc open func didType() {
        delegate?.didType(searchBar: self, text: self.textField.text)
    }
    
    // cancelButtonDidTouch: Executes whenever the user tap the cancel button
    @objc open func cancelButtonDidTouch() {
        textField.textField.text = ""
        textField.endEditing(force: true)
        delegate?.cancelButtonDidTouch(searchBar: self)
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            backgroundColor = UIColor.clear
            textField.lefImage = self.colorStyle.getSearchImage()
            updateSubNodesColors()
        }
    }
}

// MARK: SFSearchBar Extension for UITextFieldDelegate
extension SFSearchBar: UITextFieldDelegate {
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cancelButtonIsVisible = true
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.cancelButtonIsVisible = false
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
        return true
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        self.cancelButtonIsVisible = true
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.cancelButtonIsVisible = false
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true)
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
