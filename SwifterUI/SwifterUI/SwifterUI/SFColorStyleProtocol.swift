//
//  SFColorStyleProtocol.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

// minimumBrighness: Global variable to indicate minimum level of brightness for dark mode
public var minimumBrighness: CGFloat = 0.99

public protocol SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // automaticallyAdjustsColorStyle: This property enables automatic change between light and dark mode
    var automaticallyAdjustsColorStyle: Bool { get set }
    
    // colorStyle: Indicates the current color style of your view controller
    var colorStyle: SFColorStyle { get }
    
    // MARK: - Instance Methods
    
    // updateColors: This method should update the UI based on the current colorStyle, every FluidNode and FluidNodeController that needs darkmode should implement this method to set the different colors.
    // For convenience, every colorStyle provides some default(black and white) colors but you can implement whatever you need with a switch statement
    func updateColors()
    
    // updateSubNodesColors: Update subnodes colors automatically, you just have to call it at the end of updateColors() to work
    func updateSubNodesColors()
}

public extension SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // colorStyle: return the corresponding FluidColorStyle depending on user's current brightness and minimumBrighness
    public var colorStyle: SFColorStyle {
        get {
            return UIScreen.main.brightness > minimumBrighness ? SFColorStyle.light : SFColorStyle.dark
        }
    }
    
}
