//
//  SFLabelNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLabelNode: ASTextNode, SFDisplayNodeColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    open var automaticallyAdjustsColorStyle: Bool
    
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
        }
    }
    
}

extension SFLabelNode: SFTextContainer {
    
    public final func setAttributedText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        self.attributedText = NSAttributedString(string: self.text,
                                                 attributes: [
                                                    NSForegroundColorAttributeName: self.textColor,
                                                    NSFontAttributeName: self.font,
                                                    NSParagraphStyleAttributeName: paragraphStyle])
    }
    
}
















