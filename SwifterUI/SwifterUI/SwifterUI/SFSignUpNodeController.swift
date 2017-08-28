//
//  SFSignUpNodeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SFSignUpNodeController: SFViewController<SFSignUpNode>, AppleMusicLikeDismissProtocol {

    var initialPoint: CGFloat = 0
    
    // MARK: - Instance Properties
    
    public override var shouldAutorotate: Bool {
        return false
    }
    
    // MARK: - Initializers
    
    // Initialize your SFViewController with a SFNode
    // - Parameters:
    //   SFNode: Node that containts your UI
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update it's views or not
    public init(automaticallyAdjustsColorStyle: Bool) {
        super.init(SFNode: SFSignUpNode(), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.SFNode.dismissButton.addTarget(self, action: #selector(dismissButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.SFNode.signUpButton.addTarget(self, action: #selector(signUpButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didDragged(sender:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Instance Methods
    
    @objc func didDragged(sender: UIPanGestureRecognizer) {
        self.dismiss(with: sender)
    }
    
    @objc open func dismissButtonDidTouch() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc open func signUpButtonDidTouch() {
        
    }
}








