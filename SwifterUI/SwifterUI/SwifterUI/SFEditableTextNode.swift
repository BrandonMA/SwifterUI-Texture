//
//  SFEditableTextNode.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 22/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFEditableTextNode: ASEditableTextNode, SFGradientNode, SFDisplayNodeColorStyle, SFTextDisplayer, SFAnimatable {
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    open var extraAttributes: [String : SFTextAttributes] = [:] { didSet { setAttributedText() } }
    
    public var textTypeAttributes: [String : SFTextTypeIdentifier] = [:] { didSet { setAttributedText() } }
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var gradient: SFGradient?
    
    open var animator: SFAnimator = SFAnimator()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init(textKitComponents: ASTextKitComponents(attributedSeedString: nil, textContainerSize: CGSize.zero), placeholderTextKitComponents: ASTextKitComponents(attributedSeedString: nil, textContainerSize: CGSize.zero))
        automaticallyManagesSubnodes = true
        setAttributedText()
        self.textView.isEditable = false
        self.textView.isSelectable = false
    }
    
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
        self.animator.view = self.view
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = colorStyle.getMainColor()
            updateSubNodesColors()
            self.textView.indicatorStyle = colorStyle.getScrollIndicatorStyle()
            updateTextColor()
        }
    }
}
