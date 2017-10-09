//
//  SFButtonNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 06/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import UIKit

open class SFButtonNode: ASButtonNode, SFGradientNode, SFBlurredNode, SFDisplayNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = .left { didSet { setAttributedText() } }
    
    open var extraAttributes: [String : SFTextAttributes] = [:]
    
    public var textTypeAttributes: [String : SFTextTypeIdentifier] = [:] { didSet { setAttributedText() } }
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var gradient: SFGradient?
    
    open var effect: UIVisualEffect?
    
    open lazy var animator: SFAnimator = SFAnimator(with: self, animation: SFAnimationType.none)
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        self.clipsToBounds = true
    }
    
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
    }
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
        if self.effect != nil { setEffect() }
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = colorStyle.getInteractiveColor()
            self.tintColor = colorStyle.getInteractiveColor()
        }
    }
    
}

extension SFButtonNode: SFTextContainer {
    
    public func setAttributedText() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        
        self.setAttributedTitle(NSAttributedString(string: self.text,
                                                   attributes: [
                                                    NSAttributedStringKey.foregroundColor: self.textColor,
                                                    NSAttributedStringKey.font: self.font,
                                                    NSAttributedStringKey.paragraphStyle: paragraphStyle]), for: UIControlState.normal)
        
        self.setAttributedTitle(NSAttributedString(string: self.text,
                                                   attributes: [
                                                    NSAttributedStringKey.foregroundColor: self.textColor.withAlphaComponent(0.2),
                                                    NSAttributedStringKey.font: self.font,
                                                    NSAttributedStringKey.paragraphStyle: paragraphStyle]), for: UIControlState.highlighted)
    }
}




















