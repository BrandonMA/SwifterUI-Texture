//
//  MovementNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class MovementNode: WalkthroughNode<MovementMiddleNode> {
    init() {
        super.init(with: MovementMiddleNode())
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 158, green: 61, blue: 255).cgColor, UIColor(red: 205, green: 112, blue: 255).cgColor], direction: SFGradientDirection.vertical)
        bottomButton.gradient = SFGradient(with: [UIColor(red: 205, green: 112, blue: 255).cgColor, UIColor(red: 158, green: 61, blue: 255).cgColor], direction: SFGradientDirection.vertical)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
}

