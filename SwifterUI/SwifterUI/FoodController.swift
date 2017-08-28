//
//  FoodController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoodController: WalkthroughController<FoodMiddleNode> {
    
    init() {
        super.init(with: FoodNode())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleHeader = "Favorite Food"
        SFNode.bottomButton.text = "Continue"
    }
    
    override func bottomButtonDidTouch() {
        navigationController?.pushViewController(MovementController(), animated: true)
    }
}

