//
//  GradientExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 02/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class GRadientController: SFViewController<SFDisplayNode> {
    
    init() {
        super.init(SFNode: SFDisplayNode(), automaticallyAdjustsColorStyle: false)
        let red = UIColor(hex: "FF0000").cgColor
        let blue = UIColor(hex: "0000FF").cgColor
        self.SFNode.gradient = SFGradient(with: [red, blue], direction: .vertical)
        self.SFNode.clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
