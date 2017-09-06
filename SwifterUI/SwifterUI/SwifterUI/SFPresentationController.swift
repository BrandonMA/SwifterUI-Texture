//
//  SFPresentationController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFPresentationController<SFPresentingNodeType>: UIPresentationController where SFPresentingNodeType: SFDisplayNode {
    
    open var automaticallyAdjustsColorStyle: Bool = false {
        didSet {
            automaticallyAdjustsColorStyleHandler()
        }
    }
    
    public init(presented: UIViewController, presenting: UIViewController?) {
        super.init(presentedViewController: presented, presenting: presenting)
    }
    
    open func updateColors() {
        
    }
    
    open func updateSubNodesColors() {
        
    }
    
    // handleBrightnessChange: Because of the way protocols work, you need to declare an extra @objc function to call updateColors() because it is not an @objc and a notificion can't keep track of it
    @objc final func handleBrightnessChange() {
        updateColors()
    }
    
}

extension SFPresentationController: SFColorStyleProtocol {
    
    func automaticallyAdjustsColorStyleHandler() {
        if self.automaticallyAdjustsColorStyle == true {
            NotificationCenter.default.addObserver(self, selector: #selector(handleBrightnessChange), name: .UIScreenBrightnessDidChange, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
}


















