//
//  GradientExample.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 02/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class GradientNode: SFDisplayNode {
    
    lazy var middleNode: SFDisplayNode = {
        let node = SFDisplayNode(automaticallyAdjustsColorStyle: false)
        node.backgroundColor = UIColor.white
        self.animator = SFAnimator(with: node.view, animation: .zoomIn)
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        middleNode.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 100), height: ASDimension(unit: ASDimensionUnit.points, value: 100))
        let layout = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: middleNode)
        return layout
    }
    
}

class GradientController: SFViewController<GradientNode> {
    
    init() {
        super.init(SFNode: GradientNode(), automaticallyAdjustsColorStyle: false)
        let red = UIColor(hex: "FF0000").cgColor
        let blue = UIColor(hex: "0000FF").cgColor
        self.SFNode.gradient = SFGradient(with: [red, blue], direction: .vertical)
        self.SFNode.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.SFNode.middleNode.animator.delay = 1.0
        self.SFNode.middleNode.animator.animation = .scaleIn
        self.SFNode.middleNode.animator.startAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}














