//
//  SFPresentationManager.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 20/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

// SFPresentationDirection: Represent the direction of the animation
public enum SFPresentationDirection: String {
    case left
    case right
    case top
    case bottom
}

// SFPresentationType: Indicates the animation that is going to be used
public enum SFPresentationType: String {
    
    case appleMusic
    
    public func predefinedDirection() -> SFPresentationDirection {
        switch self {
        case .appleMusic: return .bottom
        }
    }
}

// SFPresentationManager: Is used to return the corresponding UIPresentationController
// SFPresentingNodeType: Indicates the Type of the presenting controller's node, this is used to typecast
open class SFPresentationManager<SFPresentingNodeType>: NSObject, UIViewControllerTransitioningDelegate where SFPresentingNodeType: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    open var direction: SFPresentationDirection
    open var animation: SFPresentationType
    
    // MARK: - Initializers
    
    // Initialize your SFPresentationManager with an specific animation
    public init(animation: SFPresentationType) {
        self.animation = animation
        self.direction = animation.predefinedDirection()
        super.init()
    }
    
    // MARK: - Instance Methods
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        switch self.animation {
        case .appleMusic:
            return SFAppleMusicPresentationController<SFPresentingNodeType>(presented: presented, presenting: presenting)
        }
    }
    
}























