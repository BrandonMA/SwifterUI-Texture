//
//  ZipUpBaseNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 21/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class ZipUpBaseNode: SFDisplayNode {
    
    var titleHeader: String = ""
    
    lazy var topGradientNode: SFDisplayNode = {
        let node = SFDisplayNode()
        return node
    }()
        
    func maskTopGradient(constrainedSize: ASSizeRange) {
        let clipPath = UIBezierPath()
        clipPath.move(to: CGPoint(x: 0, y: 124))
        clipPath.addCurve(to: CGPoint(x: constrainedSize.max.width / 2, y: 144), controlPoint1: CGPoint(x: 0, y: 124), controlPoint2: CGPoint(x: constrainedSize.max.width / 4 - 10, y: 144))
        clipPath.addCurve(to: CGPoint(x: constrainedSize.max.width, y: 124), controlPoint1: CGPoint(x: (constrainedSize.max.width / 4) * 3 + 10, y: 144), controlPoint2: CGPoint(x: constrainedSize.max.width, y: 124))
        clipPath.addLine(to: CGPoint(x: constrainedSize.max.width, y: 0))
        clipPath.addLine(to: CGPoint(x: 0, y: 0))
        clipPath.addLine(to: CGPoint(x: 0, y: 124))
        clipPath.close()
        clipPath.usesEvenOddFillRule = true
        clipPath.addClip()
        let circleShape = CAShapeLayer()
        circleShape.path = clipPath.cgPath
        topGradientNode.layer.mask = circleShape
    }
}
