//
//  SFActivityNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFActivityNode: ASDisplayNode, SFDisplayNodeColorStyle, SFAnimatable {
    
    // MARK: - Instance Properties
    
    // activityIndicatorView: backing UIActivityIndicatorView wrapped inside an ASDisplayNode
    open let activityIndicatorView: UIActivityIndicatorView
        
    open var automaticallyAdjustsColorStyle: Bool
    
    open var animator: SFAnimator = SFAnimator()
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        
        self.automaticallyAdjustsColorStyle = automaticallyAdjustsColorStyle
        
        self.activityIndicatorView = UIActivityIndicatorView() // the new UIActivityIndicatorView as the activityIndicatorView
        
        self.activityIndicatorView.isHidden = false // By default activityIndicatorView is hidden but it must be true so it is changed here
        
        super.init()
        
        self.setViewBlock { () -> UIView in
            
            self.activityIndicatorView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            
            return self.activityIndicatorView
            
        }
        
        self.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 20), height: ASDimension(unit: ASDimensionUnit.points, value: 20)) // set a preferredLayoutSize for convenience
        
        activityIndicatorView.startAnimating() // Start animating the activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        
    }
    
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        super.didLoad()
        updateColors()
        isAnimationReady()
    }
    
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            activityIndicatorView.activityIndicatorViewStyle = self.colorStyle.getActivityIndicatorStyle()
            updateSubNodesColors()
        }
    }
    
}








