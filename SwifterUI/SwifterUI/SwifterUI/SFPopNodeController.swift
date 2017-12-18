//
//  SFPickerController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 15/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPopNodeController<SFNodeType: SFPopNode>: SFViewController<SFPopNode>, SFAppleMusicPresentable {
    
    // MARK: - Instance Properties
    
    public var appleMusicGestureRecognizer: UIPanGestureRecognizer!
    
    public var initialPoint: CGFloat = 0
    
    // MARK: - Instance Methods
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.SFNode.bar.dismissButton.addTarget(self, action: #selector(dismissButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.bar.saveButton.addTarget(self, action: #selector(saveButtonDidTouch), forControlEvents: .touchUpInside)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appleMusicGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(gesture:)))
        self.view.addGestureRecognizer(appleMusicGestureRecognizer)
    }
    
    @objc open func handle(gesture: UIPanGestureRecognizer) {
        self.appleMusicDismiss()
    }
    
    @objc open func dismissButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc open func saveButtonDidTouch() {
        
    }
}





















