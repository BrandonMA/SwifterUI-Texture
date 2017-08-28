//
//  SFGradientDirection.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

// FluidGradientDirection: Indicates the direction of a FluidGradient
public enum SFGradientDirection {
    
    case horizontal
    case vertical
    
    // MARK: - Instance Methods
    
    // getStartPoint: return the start point of a gradient depending of the orientation
    public func getStartPoint() -> CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 0.0, y: 0.5)
        case .vertical: return CGPoint(x: 0.5, y: 0.0)
        }
    }
    
    // getEndPoint: return end point of a gradient depending of the orientation
    public func getEndPoint() -> CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 1.0, y: 0.5)
        case .vertical: return CGPoint(x: 0.5, y: 1.0)
        }
    }
}
