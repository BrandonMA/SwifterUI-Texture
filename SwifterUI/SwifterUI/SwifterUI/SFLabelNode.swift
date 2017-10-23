//
//  SFLabelNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLabelNode: ASTextNode, SFGradientNode, SFDisplayNodeColorStyle, SFTextDisplayer, SFAnimatable {
    
    // MARK: - Instance Properties
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFTextDisplayer
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    open var extraAttributes: [String : SFTextAttributes] = [:] { didSet { setAttributedText() } }
    
    public var textTypeAttributes: [String : SFTextTypeIdentifier] = [:] { didSet { setAttributedText() } }
    
    // MARK: - SFGradientNode
    
    open var gradient: SFGradient?
    
    // MARK: - SFAnimatable
    
    open lazy var animator: SFAnimator = SFAnimator(with: self, animations: [])
    
    // MARK: - Initializers

    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        setAttributedText()
    }
    
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = self.shouldHaveAlternativeColors == false ? colorStyle.getMainColor() : colorStyle.getPlaceholderColor()
            updateSubNodesColors()
            updateTextColor()
        }
    }
    
}












