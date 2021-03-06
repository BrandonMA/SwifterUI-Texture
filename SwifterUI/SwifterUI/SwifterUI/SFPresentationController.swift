//
//  SFPresentationController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPresentationController<SFPresentingNodeType>: UIPresentationController where SFPresentingNodeType: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open var automaticallyAdjustsColorStyle: Bool = false {
        didSet {
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    // MARK: - Initializers
    
    public init(presented: UIViewController, presenting: UIViewController?) {
        super.init(presentedViewController: presented, presenting: presenting)
    }
    
    // MARK: - Instance Methods
    
    open func updateColors() {
        
    }
    
    open func updateSubNodesColors() {
        
    }
    
    // handleBrightnessChange: Because of the way protocols work, you need to declare an extra @objc function to call updateColors() because it is not an @objc and a notification can't keep track of it
    @objc final func handleBrightnessChange() {
        updateColors()
    }
    
}

extension SFPresentationController: SFColorStyleProtocol {
    
    public func automaticallyAdjustsColorStyleHandler() {
        if self.automaticallyAdjustsColorStyle == true {
            NotificationCenter.default.addObserver(self, selector: #selector(handleBrightnessChange), name: .UIScreenBrightnessDidChange, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
}


















