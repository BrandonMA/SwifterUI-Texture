//
//  SFLoadingNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 10/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class SFLoadingNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open override var alpha: CGFloat {
        didSet {
            if alpha == 1.0 {
                self.activityNode.activityIndicatorView.startAnimating()
            } else {
                self.activityNode.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // activityNode: SFActivityNode use to show the user a loading animation while he waits
    open lazy var activityNode: SFActivityNode = {
        let node = SFActivityNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    // MARK: - Instance Methods
    
    open override func didLoad() {
        self.shouldHaveBackgroundBlur = true
        super.didLoad()
    }

    // layoutSpecThatFits: Layout all subnodes
    override open func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let activityNodeLayout = ASCenterLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumSize, child: activityNode)
        return activityNodeLayout
    }
}












