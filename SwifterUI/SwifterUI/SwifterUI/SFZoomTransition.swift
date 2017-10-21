//
//  SFZoomInTransition.swift
//  SwifterUI
//
//  Created by brandon maldonado alonso on 26/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFZoomTransition: SFTransition {
    public init(operation: UINavigationControllerOperation) {
        super.init(animator: SFAnimator(animations: [.zoomIn]), operation: operation)
    }
}
