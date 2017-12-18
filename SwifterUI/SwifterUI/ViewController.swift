//
//  ViewController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class ViewController: SFViewController<Node> {
    
    init() {
        super.init(SFNode: Node(), automaticallyAdjustsColorStyle: true)
        self.SFNode.button.addTarget(self, action: #selector(showNext), forControlEvents: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showNext() {
        let controller = SFPopNodeController(SFNode: SFPopNode(with: Node(), automaticallyAdjustsColorStyle: true), automaticallyAdjustsColorStyle: true)
        let manager: SFPresentationManager<Node> = SFPresentationManager(animation: .appleMusic)
        controller.transitioningDelegate = manager
        controller.modalPresentationStyle = .custom
        present(controller, animated: true, completion: nil)
    }    
}
