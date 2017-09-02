//
//  SFLoginNodeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 23/07/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SFLoginNodeController: SFViewController<SFLoginNode> {
    
    // MARK: - Instance Properties
    
    public override var shouldAutorotate: Bool {
        return false
    }
    
    var signUpController: SFSignUpNodeController? = nil
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFLoginNode(), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        SFNode.signInButton.addTarget(self, action: #selector(signInButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        SFNode.signUpButton.addTarget(self, action: #selector(signUpButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    @objc open func signInButtonDidTouch() {
    }
    
    @objc fileprivate func signUpButtonDidTouch() {
        guard let signUpController = self.signUpController else { return }
        let presentationManager: SFPresentationManager<SFLoginNode> = SFPresentationManager(animation: .appleMusicLike)
        signUpController.transitioningDelegate = presentationManager
        signUpController.modalPresentationStyle = .custom
        present(signUpController, animated: true, completion: nil)
    }
}















