//
//  WelcomeController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class WelcomeController: WalkthroughController<WelcomeMiddleNode> {
    
    init() {
        super.init(with: WelcomeNode())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleHeader = "Welcome to ZipUp"
        SFNode.bottomButton.text = "Continue"
    }
    
    override func bottomButtonDidTouch() {
        navigationController?.pushViewController(GenderController(), animated: true)
    }
}
