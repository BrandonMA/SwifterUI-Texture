//
//  MovementController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class MovementController: WalkthroughController<MovementMiddleNode> {
    
    init() {
        super.init(with: MovementNode())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleHeader = "Do you move?"
        SFNode.bottomButton.text = "Continue"
    }
    
    override func bottomButtonDidTouch() {
        navigationController?.pushViewController(BudgetController(), animated: true)
    }
}
