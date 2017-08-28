//
//  SFLabelNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLabelNode: ASTextNode, SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // color: text color of your label
    open var color: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    // font: font used for your label
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    // text: text that is going to be shown
    open var text: String = "" { didSet { setAttributedText() } }
    
    // automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    open var automaticallyAdjustsColorStyle: Bool
        
    // textAligment: Text aligment of your label
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update colors
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        automaticallyManagesSubnodes = true
        setAttributedText()
        isUserInteractionEnabled = true
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    // setAttributedText: Set the attributes of your label node under the hood whenever you update one of it's three properties
    public final func setAttributedText() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        
        self.attributedText = NSAttributedString(string: self.text,
                                                 attributes: [
                                                    NSForegroundColorAttributeName: self.color,
                                                    NSFontAttributeName: self.font,
                                                    NSParagraphStyleAttributeName: paragraphStyle
            ])
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.color = colorStyle.getMainColor()
            updateSubNodesColors()
        }
    }
    
}

















