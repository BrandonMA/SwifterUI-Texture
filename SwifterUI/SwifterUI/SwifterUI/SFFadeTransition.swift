//
//  SFFadeTransition.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFFadeTransition: SFTransition {
    public init(operation: UINavigationControllerOperation) {
        super.init(animator: SFAnimator(animations: [SFFadeAnimation(type: .inside)]), operation: operation)
    }
}
