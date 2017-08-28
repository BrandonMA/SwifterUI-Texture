//
//  SFButtonNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 06/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import UIKit

open class SFButtonNode: ASButtonNode, SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // textColor: Color of your button's text
    open var textColor: UIColor = UIColor.clear { didSet { setTitle() } }
    
    // font: Font used for your button's text
    open var font: UIFont = UIFont.systemFont() { didSet { setTitle() } }
    
    // text: Button's text
    open var text: String = "" { didSet { setTitle() } }
    
    // automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    open var automaticallyAdjustsColorStyle: Bool
    
    // gradient: Gradient to be used as background
    open var gradient: SFGradient? { didSet {setGradient()} }
    
    private var gradientLayer: CAGradientLayer? = nil
    
    open var shouldHaveBackgroundBlur: Bool = false
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(automaticallyAdjustsColorStyle: Bool) {
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        super.init()
        self.clipsToBounds = true
    }
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func layout() {
        super.layout()
        if self.gradient != nil { setGradient() }
        if self.shouldHaveBackgroundBlur == true { addBackgroundBlur() }
    }
    
    // setTitle: Set the title of your button automatically
    fileprivate func setTitle() {
        self.setTitle(self.text, with: self.font, with: self.textColor, for: UIControlState.normal)
        self.setTitle(self.text, with: self.font, with: self.textColor.withAlphaComponent(0.2), for: UIControlState.highlighted)
    }
        
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
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
            let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                UIBlurEffectStyle.extraLight))
            blur.frame = self.bounds
            blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
            self.view.insertSubview(blur, at: 0)
        }
    }
}






















