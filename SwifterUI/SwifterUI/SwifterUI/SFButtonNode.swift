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
    
    // MARK: - SFDisplayNodeColorStyle
    
    open var automaticallyAdjustsColorStyle: Bool
    
    open var shouldHaveAlternativeColors: Bool = false
    
    // MARK: - SFTextDisplayer
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    open var aligment: NSTextAlignment = NSTextAlignment.left { didSet { setAttributedText() } }
    
    open var extraAttributes: [String : SFTextAttributes] = [:] { didSet { setAttributedText() } }
    
    public var textTypeAttributes: [String : SFTextTypeIdentifier] = [:] { didSet { setAttributedText() } }
    
    // MARK: - SFGradientNode
    
    open var gradient: SFGradient?
    
    // MARK: - SFBlurredNode
    
    open var effect: UIVisualEffect? { didSet { self.setEffect() } }
    
    // MARK: - SFAnimatable
    
    open lazy var animator: SFAnimator = SFAnimator(with: self, animations: [.none])
    
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
    
    // MARK: - SFDisplayNodeColorStyle
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            if self.shouldHaveAlternativeColors == false {
                self.textColor = colorStyle.getInteractiveColor()
                self.tintColor = colorStyle.getInteractiveColor()
                self.backgroundColor = UIColor.clear
            } else {
                self.textColor = colorStyle.getMainColor()
                self.tintColor = colorStyle.getMainColor()
                self.backgroundColor = colorStyle.getBackgroundColor()
            }
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




















