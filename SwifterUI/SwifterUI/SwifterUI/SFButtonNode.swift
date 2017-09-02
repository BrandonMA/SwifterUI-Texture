//
//  SFButtonNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 06/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import UIKit

open class SFButtonNode: ASButtonNode, SFDisplayNodeColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    open var textColor: UIColor = UIColor.clear { didSet { setAttributedText() } }
    
    open var font: UIFont = UIFont.systemFont() { didSet { setAttributedText() } }
    
    open var text: String = "" { didSet { setAttributedText() } }
    
    public var aligment: NSTextAlignment = .left { didSet { setAttributedText() } }
    
    open var automaticallyAdjustsColorStyle: Bool
    
    // gradient: Gradient to be used as background
    open var gradient: SFGradient? { didSet {setGradient()} }
    
    private var gradientLayer: CAGradientLayer? = nil
    
    open var shouldHaveBackgroundBlur: Bool = false
    
    open var blurStyle: UIBlurEffectStyle = .extraLight
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        self.clipsToBounds = true
    }
    
    public convenience override required init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
        if self.shouldHaveBackgroundBlur == true { addBackgroundBlur() }
    }
    
    public func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.textColor = colorStyle.getInteractiveColor()
            self.tintColor = colorStyle.getInteractiveColor()
        }
    }
    
    private func setGradient() {
        if self.frame.width != 0 && self.frame.height != 0 {
            guard let layer = gradient?.getGradientLayer(width: self.frame.width, height: self.frame.height) else { return }
            
            if let gradientLayer = gradientLayer {
                self.layer.replaceSublayer(gradientLayer, with: layer)
            } else {
                self.layer.insertSublayer(layer, at: 0)
            }
            
            self.gradientLayer = layer
        }
    }
    
    func addBackgroundBlur() {
        if self.frame.width != 0 && self.frame.height != 0 {
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: self.blurStyle))
            blur.frame = self.bounds
            blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
            self.view.insertSubview(blur, at: 0)
        }
    }
}

extension SFButtonNode: SFTextContainer {
    
    public func setAttributedText() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.aligment
        
        self.setAttributedTitle(NSAttributedString(string: self.text,
                                                   attributes: [
                                                    NSForegroundColorAttributeName: self.textColor,
                                                    NSFontAttributeName: self.font,
                                                    NSParagraphStyleAttributeName: paragraphStyle]), for: UIControlState.normal)
        
        self.setAttributedTitle(NSAttributedString(string: self.text,
                                                   attributes: [
                                                    NSForegroundColorAttributeName: self.textColor.withAlphaComponent(0.2),
                                                    NSFontAttributeName: self.font,
                                                    NSParagraphStyleAttributeName: paragraphStyle]), for: UIControlState.highlighted)
    }
    
}




















