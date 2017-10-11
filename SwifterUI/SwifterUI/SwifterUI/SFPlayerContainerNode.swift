//
//  SFPlayerContainerNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

open class SFPlayerContainerNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    var videoView: UIView
    
    // MARK: - Initializers
    
    init(videoView: UIView, automaticallyAdjustsColorStyle: Bool) {
        self.videoView = videoView
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.setViewBlock { () -> UIView in
            self.videoView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            return self.videoView
        }
    }
    
    public required convenience init(automaticallyAdjustsColorStyle: Bool) {
        self.init(videoView: UIView(), automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
}
