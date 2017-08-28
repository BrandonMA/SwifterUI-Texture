//
//  SFPageControlNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public class SFPageControlNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    let pageControl: UIPageControl
    
    var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.pageControl.currentPage = self.currentPage
            }
        }
    }
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public required init(automaticallyAdjustsColorStyle: Bool) {
        
        pageControl = UIPageControl()
        
        super.init(automaticallyAdjustsColorStyle: false)
        
        self.setViewBlock { () -> UIView in // Creates the backing view block
            self.pageControl.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin] // Create the autoresizingMask that fills all your node
            return self.pageControl
        }
        
        backgroundColor = UIColor.clear
        
        self.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.points, value: 7))
        
        self.currentPage = 0
    }
    
    public convenience init() {
        self.init(automaticallyAdjustsColorStyle: true)
    }
    
    // MARK: - Instance Methods
    
    override public func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            self.pageControl.currentPageIndicatorTintColor = self.colorStyle.getBackgroundColor()
            self.pageControl.pageIndicatorTintColor = self.colorStyle.getBackgroundColor().withAlphaComponent(0.30)
        }
    }
    
}
