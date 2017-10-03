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
    
    lazy var bottomButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor.red
        button.text = "Hola"
        button.cornerRadius = 10
        return button
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratioLayout = ASRatioLayoutSpec(ratio: 9/16, child: videoNode)
        bottomButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 300), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 24, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [ratioLayout, bottomButton])
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SFNode.videoNode.animator.animation = .scaleIn
        self.SFNode.bottomButton.animator.animation = .slideOutRight
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.SFNode.videoNode.animator.delay = 0.3
        self.SFNode.videoNode.animator.startAnimation()
        
        Dispatch.delay(by: 2.0, dispatchLevel: DispatchLevel.main) {
            self.SFNode.bottomButton.animator.delay = 0
            self.SFNode.bottomButton.animator.startAnimation()
        }
        
        
    }
}










