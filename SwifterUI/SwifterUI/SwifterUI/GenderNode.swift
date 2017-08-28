//
//  GenderNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class GenderNode: WalkthroughNode<GenderMiddleNode> {
    init() {
        super.init(with: GenderMiddleNode())
        topGradientNode.gradient = SFGradient(with: [UIColor(red: 255, green: 149, blue: 0).cgColor, UIColor(red: 255, green: 199, blue: 0).cgColor], direction: SFGradientDirection.vertical)
        bottomButton.gradient = SFGradient(with: [UIColor(red: 255, green: 199, blue: 0).cgColor, UIColor(red: 255, green: 149, blue: 0).cgColor], direction: SFGradientDirection.vertical)
    }
    
    required init(automaticallyAdjustsColorStyle: Bool) {
        fatalError("init(automaticallyAdjustsColorStyle:) has not been implemented")
    }
}
