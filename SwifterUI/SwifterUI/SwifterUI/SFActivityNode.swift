//
//  SFActivityNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFActivityNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    // activityIndicatorView: backing UIActivityIndicatorView wrapped inside an ASDisplayNode
    open let activityIndicatorView: UIActivityIndicatorView
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        
        
        self.activityIndicatorView = UIActivityIndicatorView() // the new UIActivityIndicatorView as the activityIndicatorView
        
        self.activityIndicatorView.isHidden = false // By default activityIndicatorView is hidden but it must be true so it is changed here
        
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        self.setViewBlock { () -> UIView in
            self.activityIndicatorView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            return self.activityIndicatorView
        }
        
        self.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 20), height: ASDimension(unit: ASDimensionUnit.points, value: 20)) // set a preferredLayoutSize for convenience
        
        activityIndicatorView.startAnimating() // Start animating the activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
    }
    
    // MARK: - Instance Methods

    // MARK: - SFDisplayNodeColorStyle
    
    open override func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            activityIndicatorView.activityIndicatorViewStyle = self.colorStyle.getActivityIndicatorStyle()
            updateSubNodesColors()
        }
    }
    
}








