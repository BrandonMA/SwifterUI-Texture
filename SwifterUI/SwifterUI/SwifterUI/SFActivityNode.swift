//
//  SFActivityNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFActivityNode: ASDisplayNode, SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // activityIndicatorView: backing UIActivityIndicatorView wrapped inside an ASDisplayNode
    public let activityIndicatorView: UIActivityIndicatorView
        
    // automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    open var automaticallyAdjustsColorStyle: Bool
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(automaticallyAdjustsColorStyle: Bool) {
        
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
    
    // Initialize the node with a automaticallyAdjustsColorStyle set to true, this should be a convinience init
    public convenience override init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        updateColors()
    }
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            activityIndicatorView.activityIndicatorViewStyle = self.colorStyle.getActivityIndicatorStyle()
            updateSubNodesColors()
        }
    }
    
}









