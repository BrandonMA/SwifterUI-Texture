//
//  BudgetController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class BudgetController: WalkthroughController<BudgetMiddleNode> {
    
    init() {
        super.init(with: BudgetNode())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleHeader = "What's your Budget?"
        SFNode.bottomButton.text = "Talk to Sophie!"
    }
    
    override func bottomButtonDidTouch() {
        showHome()
    }
    
    override func skipButtonDidTouch() {
        showHome()
    }
}






