//
//  BudgetNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class BudgetNode: WalkthroughNode<BudgetMiddleNode> {
    init() {
        super.init(with: BudgetMiddleNode())
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 30, green: 136, blue: 229).cgColor, UIColor(red: 64, green: 189, blue: 244).cgColor], direction: SFGradientDirection.vertical)
        bottomButton.gradient = SFGradient(with: [UIColor(red: 64, green: 189, blue: 244).cgColor, UIColor(red: 30, green: 136, blue: 229).cgColor], direction: SFGradientDirection.vertical)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
}
