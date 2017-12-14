//
//  SFAnimatableController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 22/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import Foundation

public protocol SFAnimatableController {
    
    // MARK: - Instance Methods
    
    // prepareAnimations: All animations implemented with an SFAnimator should be declared here
    func prepareAnimations()
    
    // startAnimations: Called automatically to begin all SFAnimations
    func startAnimations()
}
