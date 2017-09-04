//
//  GradientExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 02/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit


class GradientNode: SFDisplayNode {
    
    lazy var buttonNode: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: true)
        button.gradient = SFGradient(with: [UIColor.red.cgColor, UIColor.yellow.cgColor], direction: .vertical)
        return button
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.buttonNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 200), height: ASDimension(unit: ASDimensionUnit.points, value: 200))
        return ASCenterLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumSize, child: self.buttonNode)
    }
    
}

class GRadientController: SFViewController<GradientNode> {
    
    init() {
        super.init(SFNode: GradientNode(), automaticallyAdjustsColorStyle: false)
        self.SFNode.gradient = SFGradient(with: [UIColor.green.cgColor, UIColor.blue.cgColor], direction: .vertical)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
