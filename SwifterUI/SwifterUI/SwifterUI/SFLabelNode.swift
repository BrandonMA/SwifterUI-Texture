//
//  SFLabelNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLabelNode: ASTextNode, SFGradientProtocol, SFDisplayNodeColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    open var extraAttributes: [String : TextAttributes] = [:] { didSet { setAttributedText() } }
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var gradient: SFGradient?
    
    // MARK: - Initializers

    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        setAttributedText()
    }
    
    public convenience override required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = colorStyle.getMainColor()
            updateSubNodesColors()
            
            if extraAttributes.count != 0 {
                for attributesDict in extraAttributes {
                    guard var attributes = extraAttributes[attributesDict.key] else { return }
                    if let type = attributes[SFTextAttributeName] as? SFTextType {
                        if type == .button {
                            attributes[NSForegroundColorAttributeName] = colorStyle.getInteractiveColor()
                            extraAttributes[attributesDict.key] = attributes
                        }
                    }
                }
            }
            
        }
        
    }
    
}

extension SFLabelNode: SFTextContainer {
    
    public final func setAttributedText() {
        self.attributedText = self.mutableAttributedText
    }
}
















