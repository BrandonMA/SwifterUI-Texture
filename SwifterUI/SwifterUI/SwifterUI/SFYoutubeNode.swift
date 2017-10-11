//
//  SFYoutubeNode.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 11/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import YouTubePlayer

open class SFYoutubeNode: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    public var youtubeView: YouTubePlayerView
    
    // MARK: - Initializers
    
    required public init(automaticallyAdjustsColorStyle: Bool) {
        self.youtubeView = YouTubePlayerView()
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.setViewBlock { () -> UIView in
            self.youtubeView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
            return self.youtubeView
        }
    }
}
