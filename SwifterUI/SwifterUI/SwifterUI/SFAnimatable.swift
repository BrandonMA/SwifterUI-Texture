//
//  SFAnimatable.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 29/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFAnimatable {
    
    // MARK: - Instance Properties
    
    var animator: SFAnimator { get set }
}
