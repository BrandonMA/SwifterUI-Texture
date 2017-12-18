//
//  Node.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class Node: SFDisplayNode {
    
    lazy var button: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        button.text = "Show"
        return button
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        button.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: 1), height: ASDimension(unit: .points, value: 200))
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: button)
    }
}
