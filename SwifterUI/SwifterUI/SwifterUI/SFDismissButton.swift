//
//  SFDismissButton.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFDismissButton: SFButtonNode {
    
    // MARK: - Initializers

    required public init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    // MARK: - Instance Methods

    override open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            SFAssets.imageOfArrowDown.tint(color: self.colorStyle.getDetailColor(), alpha: 1, handler: { (image) in
                Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                    self.setImage(image, for: UIControlState.normal)
                })
            })
        }
    }
}
