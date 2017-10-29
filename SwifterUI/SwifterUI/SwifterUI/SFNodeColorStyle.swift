//
//  SFDisplayNodeColorStyleProtocol.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 28/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

public protocol SFNodeColorStyle: SFColorStyleProtocol {
    
    // MARK: - Instance Properties
    
    // shouldHaveAlternativeColors: Indicates whether it should use getAlternativeBackgroundColor or getBackgroundColor
    var shouldHaveAlternativeColors: Bool { get set }
    
    // MARK: - Initializers
    
    // Required init to set automaticallyAdjustsColorStyle
    // - Parameters:
    //   automaticallyAdjustsColorStyle: Variable to know if a node should automatically update colors
    init(automaticallyAdjustsColorStyle: Bool)
}

public extension SFNodeColorStyle where Self: ASDisplayNode {
    
    // MARK: - Instance Methods
    
    // updateSubNodesColors: This implementation of updateSubNodesColors loop over all subnodes and call updateColors()
    public func updateSubNodesColors() {
        
        // Loop all subnodes on background thread to improve UI performance
        Dispatch.addAsyncTask(to: DispatchLevel.background) {
            
            for subnode in self.subnodes {
                
                if let subnode = subnode as? SFNodeColorStyle {
                    
                    // Return to the main thread to make UI related changes
                    Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                        UIView.animate(withDuration: 0.3, animations: {
                            subnode.updateColors()
                        })
                    })
                }
            }
        }
    }
}

