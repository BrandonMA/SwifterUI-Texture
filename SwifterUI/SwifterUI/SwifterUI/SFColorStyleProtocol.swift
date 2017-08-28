//
//  SFColorStyleProtocol.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 12/06/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// minimumBrighness: Global variable to indicate minimum level of brightness for dark mode
public var minimumBrighness: CGFloat = 0.30

// MARK: - Protocol Declaration

// SFColorStyleProtocol: This protocol defines all properties and methods needed to update colors based on brightness. By inheriting from this method it is really easy to implement different styles to your UI based on the brightness, at the moment the only 2 current styles are light and dark
public protocol SFColorStyleProtocol: class {
    
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

// MARK: - FluidColorStyleProtocol Default Extension

public extension SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // colorStyle: return the corresponding FluidColorStyle depending on user's current brightness and minimumBrighness
    var colorStyle: SFColorStyle {
        get {
            return UIScreen.main.brightness > minimumBrighness ? SFColorStyle.light : SFColorStyle.dark
        }
    }
    
}

// MARK: - FluidColorStyleProtocol where Self: ASDisplayNode

public extension SFColorStyleProtocol where Self: ASDisplayNode {
    
    // MARK: - Instance Methods
    
    // updateSubNodesColors: This implementation of updateSubNodesColors loop over all subnodes and call updateColors()
    func updateSubNodesColors() {
        
        // Loop all subnodes on background thread to improve UI performance
        Dispatch.addAsyncTask(to: DispatchLevel.background) {
            
            for subnode in self.subnodes {
                
                if let subnode = subnode as? SFColorStyleProtocol {
                                        
                    // Return to the main thread to make UI related changes
                    Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                        UIView.animate(withDuration: 0.4, animations: {
                            subnode.updateColors()
                        })
                    })
                }
            }
        }
    }
}
