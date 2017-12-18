//
//  SFDismissButton.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 27/08/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFDismissButton: SFButtonNode {
    
    open override var tintColor: UIColor! {
        didSet {
            changeImage(to: self.tintColor)
        }
    }
    
    // MARK: - Initializers

    required public init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.setImage(SFAssets.imageOfArrowDown, for: .normal)
    }
    
    // MARK: - Instance Methods
    
    open func changeImage(to color: UIColor) {
        SFAssets.imageOfArrowDown.tint(color: color, alpha: 1, handler: { (image) in
            Dispatch.addAsyncTask(to: .main, handler: {
                self.setImage(image, for: .normal)
            })
        })
    }

    override open func updateColors() {
        if self.automaticallyAdjustsColorStyle == true {
            changeImage(to: self.colorStyle.getDetailColor())
        }
    }
}









