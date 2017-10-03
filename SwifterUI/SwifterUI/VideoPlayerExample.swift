//
//  VideoPlayerExample.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 01/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class VideoPlayerNodeExample: SFDisplayNode {
    
    lazy var videoNode: SFVideoPlayer = {
        let node = SFVideoPlayer(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratioLayout = ASRatioLayoutSpec(ratio: 9/16, child: videoNode)
        return ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: ratioLayout)
    }
    
}

class VideoPlayerControllerExample: SFViewController<VideoPlayerNodeExample> {
    
    init() {
        super.init(SFNode: VideoPlayerNodeExample(), automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else { return }
        self.SFNode.videoNode.load(videoURL: URL(fileURLWithPath: path), parentController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.SFNode.videoNode.animator.animation = .slideOutTop
        Dispatch.delay(by: 3.0, dispatchLevel: DispatchLevel.background) {
            self.SFNode.videoNode.animator.startAnimation()
        }
    }
}










